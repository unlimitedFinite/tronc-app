class AddTroncReferenceToEmployeeRecords < ActiveRecord::Migration[6.0]
  def change
    add_reference :employee_records, :tronc_record, index: true
  end
end
