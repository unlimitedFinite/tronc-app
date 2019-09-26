class TroncRecord < ApplicationRecord
  has_many :employee_records
  belongs_to :report
  belongs_to :user

  after_create :make_employee_records

  def make_employee_records()
    # Define list of active employees
    employees = Employee.where(active: true, user: self.user)
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
    @report_this_month = Report.where(user: record.user).last
    @report_last_month = Report.where(user: record.user).second_to_last

    if d < 6 && m == @report_this_month.report_start.next_month # Tronc Record belongs to last months report
      record.report = @report_last_month
    else # Tronc Record belongs to this months report
      record.report = @report_this_month
    end
    # Report.tally_up(record)
  end

  def self.check_next_record(record)
    date = record.week_end + 7
    m = date.month
    report = Report.where(user: record.user).last
    if !report.nil?
      if date.day < 6 && m == report.report_start.next_month.month
        return false
      elsif m == report.report_start.month
        return false
      else
        Report.mark_complete(report)
        Report.create(report_start: report.report_start.next_month, user: record.user)
      end
    else
      # byebug
      date = record.week_end
      until date.day == 6
        date -= 1
      end
      record.report = Report.create(report_start: date, user: record.user)
      record.save
    end
  end
end

# if next week
