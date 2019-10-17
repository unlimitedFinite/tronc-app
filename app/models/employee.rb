class Employee < ApplicationRecord
  has_many :employee_records
  belongs_to :user

  def self.with_records_in(tronc)
    includes(:employee_records)
      .references(:employee_records)
      .where(user: tronc.user)
      .where(employee_records: { tronc_record_id: tronc.id.to_i })
  end
end
