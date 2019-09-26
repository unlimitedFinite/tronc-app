class EmployeeRecordsController < ApplicationController
  before_action :set_employee_record, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /employee_records
  # GET /employee_records.json
  def index
    @employee_records = EmployeeRecord.all
  end

  # GET /employee_records/1
  # GET /employee_records/1.json
  def show
  end

  # GET /employee_records/new
  def new
    @employee_record = EmployeeRecord.new
  end

  # GET /employee_records/1/edit
  def edit
  end

  # POST /employee_records
  # POST /employee_records.json
  def create
    @employee_record = EmployeeRecord.new(employee_record_params)

    respond_to do |format|
      if @employee_record.save
        format.html { redirect_to @employee_record, notice: 'Employee record was successfully created.' }
        format.json { render :show, status: :created, location: @employee_record }
      else
        format.html { render :new }
        format.json { render json: @employee_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_records/1
  # PATCH/PUT /employee_records/1.json
  def update
    respond_to do |format|
      if @employee_record.update(employee_record_params)
        format.html { redirect_to @employee_record, notice: 'Employee record was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee_record }
      else
        format.html { render :edit }
        format.json { render json: @employee_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_records/1
  # DELETE /employee_records/1.json
  def destroy
    @employee_record.destroy
    respond_to do |format|
      format.html { redirect_to employee_records_url, notice: 'Employee record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_record
      @employee_record = EmployeeRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_record_params
      params.require(:employee_record).permit(:week_end, :tips, :employee_id)
    end
end
