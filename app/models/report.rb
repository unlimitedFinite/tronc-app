class Report < ApplicationRecord
  has_many :tronc_records

  def self.tally_up(record)
    report = record.report
    report.gross_tips += record.gross_tips
    report.tax_due += record.tax_due
    report.net_tips = report.gross_tips - report.tax_due
    report.save
  end
end
