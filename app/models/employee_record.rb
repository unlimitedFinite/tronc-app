class EmployeeRecord < ApplicationRecord
  include Calculations

  belongs_to :employee
  belongs_to :tronc_record
  belongs_to :report

  monetize :tips, as: 'gross'

  def self.rebalance_tips(tronc_id)
    records = EmployeeRecord.where(tronc_record: tronc_id)
    # Define money to be split (self.tips - self.tax_due)
    # share = (tronc_record.gross_tips - tronc_record.tax_due) / records.length
    # update records
    gross = TroncRecord.find(tronc_id).gross_tips
    share = gross / records.length
    records.each do |r|
      r.tips = share
      r.save
    end
  end

end
