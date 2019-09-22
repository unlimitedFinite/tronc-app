require "application_system_test_case"

class EmployeeRecordsTest < ApplicationSystemTestCase
  setup do
    @employee_record = employee_records(:one)
  end

  test "visiting the index" do
    visit employee_records_url
    assert_selector "h1", text: "Employee Records"
  end

  test "creating a Employee record" do
    visit employee_records_url
    click_on "New Employee Record"

    fill_in "Employee", with: @employee_record.employee_id
    fill_in "Tips", with: @employee_record.tips
    fill_in "Week end", with: @employee_record.week_end
    click_on "Create Employee record"

    assert_text "Employee record was successfully created"
    click_on "Back"
  end

  test "updating a Employee record" do
    visit employee_records_url
    click_on "Edit", match: :first

    fill_in "Employee", with: @employee_record.employee_id
    fill_in "Tips", with: @employee_record.tips
    fill_in "Week end", with: @employee_record.week_end
    click_on "Update Employee record"

    assert_text "Employee record was successfully updated"
    click_on "Back"
  end

  test "destroying a Employee record" do
    visit employee_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Employee record was successfully destroyed"
  end
end
