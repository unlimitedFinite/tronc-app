class AddDefaultToReportValues < ActiveRecord::Migration[6.0]
  def change
    change_column :reports, :gross_tips, :integer, :default => 0
    change_column :reports, :tax_due, :integer, :default => 0
    change_column :reports, :net_tips, :integer, :default => 0
  end
end
