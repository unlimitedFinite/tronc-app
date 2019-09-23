class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    # @reports = Report.where.not(gross_tips: 0)
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @tronc_records = TroncRecord.where(report: @report)
    @employee_records = EmployeeRecord.all
    @employees = @employee_records.group_by(&:employee)
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new
    if Report.last.month == 12
      @report.month = 1
      @report.year = Report.last.year + 1
    else
      @report.month = Report.last.month + 1
      @report.year = Report.last.year
    end

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    byebug
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      # params.require(:report).permit()
    end
end
