require 'test_helper'

class EmployeeRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee_record = employee_records(:one)
  end

  test "should get index" do
    get employee_records_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_record_url
    assert_response :success
  end

  test "should create employee_record" do
    assert_difference('EmployeeRecord.count') do
      post employee_records_url, params: { employee_record: { employee_id: @employee_record.employee_id, tips: @employee_record.tips, week_end: @employee_record.week_end } }
    end

    assert_redirected_to employee_record_url(EmployeeRecord.last)
  end

  test "should show employee_record" do
    get employee_record_url(@employee_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_record_url(@employee_record)
    assert_response :success
  end

  test "should update employee_record" do
    patch employee_record_url(@employee_record), params: { employee_record: { employee_id: @employee_record.employee_id, tips: @employee_record.tips, week_end: @employee_record.week_end } }
    assert_redirected_to employee_record_url(@employee_record)
  end

  test "should destroy employee_record" do
    assert_difference('EmployeeRecord.count', -1) do
      delete employee_record_url(@employee_record)
    end

    assert_redirected_to employee_records_url
  end
end
