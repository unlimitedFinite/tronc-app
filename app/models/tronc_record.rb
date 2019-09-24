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
    y = record.week_end.year
    @report_this_month = Report.find_by(month: m, year: y)
    @report_last_month = Report.find_by(month: m - 1, year: y)
    if d < 6 # Tronc Record belongs to last months report
      record.report = @report_last_month
    else # Tronc Record belongs to this months report
      record.report = @report_this_month
    end
    if record.report == nil # Tronc belongs to new report
      if m + 1 == 13
        month = 1
        year = y + 1
      else
        month = m
        year = y
      end
      # Close this months report and add record to new report
      Report.mark_complete(@report_last_month)
      record.report = Report.create(
        month: month,
        year: year
      )
    end
    Report.tally_up(record)
  end
end
