class TroncRecord < ApplicationRecord
  has_many :employee_records
  belongs_to :report

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
        tronc_record: self,
        report_id: self.report.id
      )
    end
  end

  def self.add_to_report(record)
    d = record.week_end.day
    m = record.week_end.month
    y = record.week_end.year
    if m == 1
      m = 13
    end
    byebug
    @report_this_month = Report.find_by(month: m, year: y)
    if m == 13
      @report_last_month = Report.find_by(month: m - 1, year: y - 1)
    else
      @report_last_month = Report.find_by(month: m - 1, year: y)
    end
    if d < 6 && m == Report.last.month + 1 # Tronc Record belongs to last months report
      record.report = @report_last_month
    else # Tronc Record belongs to this months report
      record.report = @report_this_month
    end
    Report.tally_up(record)

    # if record.report == nil # Tronc belongs to new report
    #   if m + 1 == 13
    #     month = 1
    #     year = y + 1
    #   else
    #     month = m
    #     year = y
    #   end
    #   # Close this months report and add record to new report
    #   record.report = Report.create(
    #     month: month,
    #     year: year
    #   )
    # end
  end

  def self.check_next_record(week_end)
    week_end += 7
    d = week_end.day
    m = week_end.month
    y = week_end.year
    if m == 1
      m = 13
    end
    # @report_this_month = Report.find_by(month: m, year: y)
    # @report_last_month = Report.find_by(month: m - 1, year: y)
    if d < 6 && m == Report.last.month + 1
      return false
    elsif m == Report.last.month
      return false
    else
      if m == 13
        m = 1
      end
      byebug
      Report.mark_complete(Report.last)
      Report.create(
        month: m,
        year: y
      )
    end
  end
end

# if next week
