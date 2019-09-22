class TroncRecord < ApplicationRecord
  has_many :employee_records

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
end
