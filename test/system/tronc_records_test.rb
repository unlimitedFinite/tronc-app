require "application_system_test_case"

class TroncRecordsTest < ApplicationSystemTestCase
  setup do
    @tronc_record = tronc_records(:one)
  end

  test "visiting the index" do
    visit tronc_records_url
    assert_selector "h1", text: "Tronc Records"
  end

  test "creating a Tronc record" do
    visit tronc_records_url
    click_on "New Tronc Record"

    fill_in "Employee record", with: @tronc_record.employee_record_id
    fill_in "Gross tips", with: @tronc_record.gross_tips
    fill_in "Tax due", with: @tronc_record.tax_due
    fill_in "Week end", with: @tronc_record.week_end
    click_on "Create Tronc record"

    assert_text "Tronc record was successfully created"
    click_on "Back"
  end

  test "updating a Tronc record" do
    visit tronc_records_url
    click_on "Edit", match: :first

    fill_in "Employee record", with: @tronc_record.employee_record_id
    fill_in "Gross tips", with: @tronc_record.gross_tips
    fill_in "Tax due", with: @tronc_record.tax_due
    fill_in "Week end", with: @tronc_record.week_end
    click_on "Update Tronc record"

    assert_text "Tronc record was successfully updated"
    click_on "Back"
  end

  test "destroying a Tronc record" do
    visit tronc_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tronc record was successfully destroyed"
  end
end
