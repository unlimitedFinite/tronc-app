class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.integer :gross_tips
      t.integer :tax_due
      t.integer :net_tips
      t.integer :month
      t.integer :year

      t.timestamps
    end
    add_reference :tronc_records, :report, index: true
  end
end
