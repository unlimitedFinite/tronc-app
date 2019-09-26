class TroncRecordsController < ApplicationController
  before_action :set_tronc_record, only: [:show, :edit, :update, :destroy]

  # GET /tronc_records
  # GET /tronc_records.json
  def index
    @tronc_records = TroncRecord.all
  end

  # GET /tronc_records/1
  # GET /tronc_records/1.json
  def show
  end

  # GET /tronc_records/new
  def new
    @tronc_record = TroncRecord.new
    respond_to do |f|
      f.html
      f.js
    end
  end

  # GET /tronc_records/1/edit
  def edit
  end

  # POST /tronc_records
  # POST /tronc_records.json
  def create
    @tronc_record = TroncRecord.new(tronc_record_params)
    @tronc_record.week_end = TroncRecord.last.week_end + 7
    @tronc_record.tax_due = @tronc_record.gross_tips / 5
    TroncRecord.add_to_report(@tronc_record)
    TroncRecord.check_next_record(@tronc_record.week_end)
    respond_to do |format|
      if @tronc_record.save
        format.html { redirect_to report_path(@tronc_record.report), notice: 'Tronc record was successfully created.' }
        format.json { render :show, status: :created, location: @tronc_record }
      else
        format.html { render :new }
        format.json { render json: @tronc_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tronc_records/1
  # PATCH/PUT /tronc_records/1.json
  def update
    respond_to do |format|
      if @tronc_record.update(tronc_record_params)
        format.html { redirect_to @tronc_record, notice: 'Tronc record was successfully updated.' }
        format.json { render :show, status: :ok, location: @tronc_record }
      else
        format.html { render :edit }
        format.json { render json: @tronc_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tronc_records/1
  # DELETE /tronc_records/1.json
  def destroy
    Report.tally_down(@tronc_record)
    @tronc_record.destroy
    respond_to do |format|
      format.html { redirect_to tronc_records_url, notice: 'Tronc record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tronc_record
      @tronc_record = TroncRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tronc_record_params
      params.require(:tronc_record).permit(:gross_tips)
    end

end
