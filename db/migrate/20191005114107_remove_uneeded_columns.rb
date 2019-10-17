class RemoveUneededColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :reports, :tax_due
    remove_column :reports, :net_tips
    remove_column :tronc_records, :tax_due
  end
end
