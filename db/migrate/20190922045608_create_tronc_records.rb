class CreateTroncRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :tronc_records do |t|
      t.integer :gross_tips
      t.date :week_end
      t.integer :tax_due

      t.timestamps
    end
  end
end
