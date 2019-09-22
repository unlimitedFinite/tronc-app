class CreateEmployeeRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :employee_records do |t|
      t.date :week_end
      t.integer :tips
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
