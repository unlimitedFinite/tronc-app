class Employee < ApplicationRecord
  has_many :employee_records
  belongs_to :user
end
