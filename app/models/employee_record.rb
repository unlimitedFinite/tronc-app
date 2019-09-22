class EmployeeRecord < ApplicationRecord
  belongs_to :employee
  belongs_to :tronc_record
  belongs_to :report
end
