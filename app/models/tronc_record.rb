class TroncRecord < ApplicationRecord
  has_many :employee_records
  belongs_to :report

  after_create :make_employee_records

  def make_employee_records
    # Define list of active employees
    employees = Employee.where(active: true)
    # Define money to be split (self.tips - self.tax_due)
    share = (self.gross_tips - self.tax_due) / employees.length
    # create records
    employees.each do |e|
      EmployeeRecord.create(
        employee: e,
        week_end: self.week_end,
        tips: share,
        tronc_record: self,
        report_id: self.report.id
      )
    end
  end

  def self.add_to_report(record)
    d = record.week_end.day
    m = record.week_end.month
    @report_this_month = Report.last
    @report_last_month = Report.second_to_last

    if d < 6 && m == Report.last.report_start.next_month # Tronc Record belongs to last months report
      record.report = @report_last_month
    else # Tronc Record belongs to this months report
      record.report = @report_this_month
    end
    Report.tally_up(record)
  end

  def self.check_next_record(week_end)
    week_end += 7
    m = week_end.month

    if week_end.day < 6 && m == Report.last.report_start.next_month.month
      return false
    elsif m == Report.last.report_start.month
      return false
    else
      Report.mark_complete(Report.last)
      Report.create(report_start: Report.last.report_start.next_month)
    end
  end
end

# if next week
