class Report < ApplicationRecord
  has_many :tronc_records
  has_many :employee_records
  belongs_to :user

  before_create :default_values

  monetize :gross_tips, as: 'gross'
  monetize :net_tips, as: 'net'
  monetize :tax_due, as: 'tax'

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

  def self.update_report_value(record, old_value)
    report = record.report
    report.gross_tips -= old_value
    report.gross_tips += record.gross_tips
    report.save
  end

  def self.mark_complete(report)
    report.completed = true
    report.save
  end

  private

    def default_values
      self.gross ||= 0
      self.tax ||= 0
      self.net ||= 0
    end
end
