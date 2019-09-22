class Report < ApplicationRecord
  has_many :tronc_records
  has_many :employee_records

  default_scope { order(year: :ASC, month: :ASC) }
  before_create :default_values

  def self.tally_up(record)
    report = record.report
    report.gross_tips += record.gross_tips
    report.tax_due += record.tax_due
    report.net_tips = report.gross_tips - report.tax_due
    report.save
  end

  def self.tally_down(record)
    report = record.report
    report.gross_tips -= record.gross_tips
    report.tax_due -= record.tax_due
    report.net_tips = report.gross_tips - report.tax_due
    report.save
  end

  private

    def default_values
      self.gross_tips ||= 0
      self.tax_due ||= 0
      self.net_tips ||= 0
    end
end
