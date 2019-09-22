class AddReportReferenceToEmployeeRecord < ActiveRecord::Migration[6.0]
  def change
    add_reference :employee_records, :report, index: true
  end
end
