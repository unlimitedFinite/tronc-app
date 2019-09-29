class AddDefaultToEmployeeActive < ActiveRecord::Migration[6.0]
  def change
    change_column :employees, :active, :boolean, :default => true
  end
end
