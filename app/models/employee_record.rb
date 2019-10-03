class EmployeeRecord < ApplicationRecord
  belongs_to :employee
  belongs_to :tronc_record
  belongs_to :report

  monetize :tips, as: 'net'

  def self.rebalance_tips(tronc_record, records)
    # Define money to be split (self.tips - self.tax_due)
    share = (tronc_record.gross_tips - tronc_record.tax_due) / records.length
    # update records
    records.each do |r|
      r.tips = share
      r.save
    end
  end
end
