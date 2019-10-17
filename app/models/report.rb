class Report < ApplicationRecord
  include Calculations

  has_many :tronc_records
  has_many :employee_records
  belongs_to :user

  before_create :default_values

  monetize :gross_tips, as: 'gross'

  def self.tally_up(record)
    report = record.report
    report.gross_tips += record.gross_tips
    # report.tax_due += record.tax_due
    # report.net_tips = report.gross_tips - report.tax_due
    report.save
  end

  def self.tally_down(record)
    report = record.report
    report.gross_tips -= record.gross_tips
    # report.tax_due -= record.tax_due
    # report.net_tips = report.gross_tips - report.tax_due
    report.save
  end

  def self.update_report_value(record, old_gross)
    report = record.report

    # new_net = record.gross_tips - record.tax_due
    # old_tax = old_gross / 5
    # old_net = old_gross - old_tax
    report.gross_tips -= old_gross
    report.gross_tips += record.gross_tips
    # report.tax_due -= old_tax
    # report.tax_due += record.tax_due
    # report.net_tips -= old_net
    # report.net_tips += new_net
    # byebug
    report.save
  end

  def self.mark_complete(report)
    report.completed = true
    report.save
  end

  private

    def default_values
      self.gross ||= 0
      # byebug
    end
end
