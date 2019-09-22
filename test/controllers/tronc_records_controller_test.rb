require 'test_helper'

class TroncRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tronc_record = tronc_records(:one)
  end

  test "should get index" do
    get tronc_records_url
    assert_response :success
  end

  test "should get new" do
    get new_tronc_record_url
    assert_response :success
  end

  test "should create tronc_record" do
    assert_difference('TroncRecord.count') do
      post tronc_records_url, params: { tronc_record: { employee_record_id: @tronc_record.employee_record_id, gross_tips: @tronc_record.gross_tips, tax_due: @tronc_record.tax_due, week_end: @tronc_record.week_end } }
    end

    assert_redirected_to tronc_record_url(TroncRecord.last)
  end

  test "should show tronc_record" do
    get tronc_record_url(@tronc_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_tronc_record_url(@tronc_record)
    assert_response :success
  end

  test "should update tronc_record" do
    patch tronc_record_url(@tronc_record), params: { tronc_record: { employee_record_id: @tronc_record.employee_record_id, gross_tips: @tronc_record.gross_tips, tax_due: @tronc_record.tax_due, week_end: @tronc_record.week_end } }
    assert_redirected_to tronc_record_url(@tronc_record)
  end

  test "should destroy tronc_record" do
    assert_difference('TroncRecord.count', -1) do
      delete tronc_record_url(@tronc_record)
    end

    assert_redirected_to tronc_records_url
  end
end
