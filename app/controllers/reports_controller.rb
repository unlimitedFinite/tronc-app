class ReportsController < ApplicationController
  include Calculations

  before_action :set_report, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # before_action :check_current_user, only: [:show]

  def index
    @reports = Report.all.where(user: current_user).order(report_start: 'DESC')
    if @reports.length == 0
      redirect_to :setup_path
    end
  end

  def show
    @tronc_records = TroncRecord.where(report: @report, user: current_user).order(week_end: 'ASC')
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
        dpi: 75,
        header: { right: 'Page: [page] of [topage]'}
      end
    end
  end

  def new
    @report = Report.new
    @months_array = []
    date = Date.new(2019, 4, 6)
    @selected = Date.today
    @selected -= 1 until @selected.day == 6
    while date < Date.today do
      @months_array << [date.strftime("%B %Y"), date]
      date = date.next_month
    end
    respond_to do |f|
      f.html
      f.js
    end
  end
  # POST /reports
  # POST /reports.json
  def create
    if !Report.where(user: current_user).all.length.positive?
      @report = Report.new(report_params)
    else
      @report = Report.new
      last_user_report = Report.where(user: current_user).last
      @report.report_start = last_user_report.next_month
    end
    @report.user = current_user
    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :setup }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
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

  def setup
    @last_saturday = Date.today
    @last_saturday -= 1 until @last_saturday.saturday?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
      check_current_user(@report)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:report_start)
    end

    def check_current_user(report)
      unless report.user == current_user
        redirect_to reports_path
      end
    end
end
