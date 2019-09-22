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
        tronc_record: self
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
  end
end
