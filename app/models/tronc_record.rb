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
    if d < 6
      record.report = Report.find_by(month: m - 1, year: y)
    else
      record.report = Report.find_by(month: m, year: y)
    end
    # if d < 6
    #   record.report = Report.all[-2]
    # else
    #   record.report = Report.last
    # end
    if record.report == nil
      if m + 1 == 13
        month = 1
        year = y + 1
      else
        month = m
        year = y
      end
      record.report = Report.create(
        month: month,
        year: year
      )
    end
    Report.tally_up(record)
  end
end
