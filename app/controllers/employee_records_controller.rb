class EmployeeRecordsController < ApplicationController
  before_action :set_employee_record, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  def new
    @tronc = TroncRecord.find(params[:tronc])
    @all_employees = Employee.where(user: current_user)
    @employees_in_tronc = Employee.with_records_in(@tronc)
    @employees_not_in_tronc = @all_employees - @employees_in_tronc
    @employees = []
    @employees_not_in_tronc.each do |k|
      @employees << [k[:name], k[:id]]
    end

    @employee_record = EmployeeRecord.new
    respond_to do |f|
      f.html
      f.js
    end
  end

  def create
    @employee_record = EmployeeRecord.new(employee_record_params)
    @tronc_record = TroncRecord.find(params['tronc_record'])
    @employee_record.tronc_record = @tronc_record
    @employee_record.week_end = @tronc_record.week_end
    @employee_record.report = @tronc_record.report
    @employee_record.tips = 0
    respond_to do |format|
      if @employee_record.save
        EmployeeRecord.rebalance_tips(@tronc_record.id)
        format.html { redirect_to edit_tronc_record_path(@tronc_record), success: 'Tronc Record has been updated' }
        format.js
      else
        format.html { redirect_to edit_tronc_record_path(@tronc_record), alert: 'An error occured, try again' }
        format.js
      end
    end
  end

  def destroy
    @tronc_record = @employee_record.tronc_record
    @employee_records = EmployeeRecord.where(tronc_record: @tronc_record)
    if @employee_record.destroy
      EmployeeRecord.rebalance_tips(@tronc_record.id)
      respond_to do |format|
        format.html { redirect_to tronc_record_path(@tronc_record)}
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_record
      @employee_record = EmployeeRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_record_params
      params.require(:employee_record).permit(:employee_id, :tronc_record)
    end
end
