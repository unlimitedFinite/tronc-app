class TroncRecordsController < ApplicationController
  include Calculations

  before_action :set_tronc_record, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @reports = Report.where(user: current_user)
    @tronc_record = TroncRecord.new(user: current_user)
    @employees = Employee.where(user: current_user, active: true)
    if TroncRecord.where(user: current_user).length > 1
      @this_week_start = TroncRecord.where(user: current_user).last.week_end + 1
    else
      TroncRecord.save_first_attributes(@tronc_record)
      @this_week_start = @tronc_record.week_end - 6
    end
    @this_week_end = @this_week_start + 6
    @this_week_start = @this_week_start.strftime("#{@this_week_start.day.ordinalize} %b")
    @this_week_end = @this_week_end.strftime("#{@this_week_end.day.ordinalize} %b")
    @months_array = []
    @last_saturday = Date.today
    @last_saturday -= 1 until @last_saturday.saturday?
    date = Date.new(2019, 4, 6)
    while date < Date.today do
      @months_array << [date.strftime("%a #{date.day.ordinalize} %b %y"), date]
      date = date.next_month
    end
    respond_to do |f|
      f.html
      f.js
    end
  end


  def create
    @tronc_record = TroncRecord.new(tronc_record_params)
    @tronc_record.user = current_user
    if !current_user.tronc_records.length.positive?
      TroncRecord.save_first_attributes(@tronc_record)
    else
      TroncRecord.save_attributes(@tronc_record)
      TroncRecord.add_to_report(@tronc_record)
    end
    TroncRecord.check_next_record(@tronc_record)
    Report.tally_up(@tronc_record)

    respond_to do |format|
      if @tronc_record.save
        format.html { redirect_to report_path(@tronc_record.report), notice: 'Tronc record was successfully created.' }
        format.json { render :show, status: :created, location: @tronc_record }
      else
        format.html { redirect_to new_tronc_record_path }
        format.json { render json: @tronc_record.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @employee_records = EmployeeRecord.where(tronc_record: @tronc_record)

    @employees = []
    @employee_records.each do |er|
      @employees << er.employee
    end


    @this_week_end = @tronc_record.week_end
    @this_week_start = @this_week_end - 6
    @this_week_start = @this_week_start.strftime("#{@this_week_start.day.ordinalize} %b")
    @this_week_end = @this_week_end.strftime("#{@this_week_end.day.ordinalize} %b")
  end

  def load_employees
    @employee_records = @tronc_record.employee_records
  end

  def update
    old_value = TroncRecord.find(params[:id]).gross_tips
    report = Report.find(@tronc_record.report_id)
    @tronc_record.gross_tips = tronc_record_params[:gross_tips]
    # @tronc_record.tax_due = @tronc_record.gross_tips / 5
    respond_to do |format|
      if @tronc_record.save
        EmployeeRecord.rebalance_tips(@tronc_record.id)
        Report.update_report_value(@tronc_record, old_value)
        format.html { redirect_to report_path(report), notice: 'Tronc record was successfully updated.' }
        format.json { render :show, status: :ok, location: @tronc_record }
      else
        format.html { render :edit }
        format.json { render json: @tronc_record.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tronc_record
      # byebug
      @tronc_record = TroncRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tronc_record_params
      params.require(:tronc_record).permit(:gross_tips, :week_end)
    end

end
