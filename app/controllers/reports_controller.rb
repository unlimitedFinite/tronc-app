class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # GET /reports
  # GET /reports.json
  def index
    # @reports = Report.where.not(gross_tips: 0)
    @reports = Report.all.where(user: current_user).order(report_start: 'DESC')
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @tronc_records = TroncRecord.where(report: @report)
    @employee_records = EmployeeRecord.where(report: @report)
    @employees = @employee_records.group_by(&:employee)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Tronc Report",
        template: 'reports/show_pdf.html.erb',
        page_size: 'A4',
        layout: 'pdf.html',
        zoom: 1,
        lowquality: true,
        dpi: 75
         # Excluding ".pdf" extension.
      end
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new
    last_user_report = Report.where(user: current_user).last
    if last_user_report.month == 12
      @report.month = 1
      @report.year = last_user_report.year + 1
    else
      @report.month = last_user_report.month + 1
      @report.year = last_user_report.year
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

  def print_pdf
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "report",
        template: 'invoices/show.html.erb',
        page_size: 'A4'
         # Excluding ".pdf" extension.
      end
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
