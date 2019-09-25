class ReplaceDateColumnInReport < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :report_start, :date
    remove_column :reports, :month
    remove_column :reports, :year
  end
end
