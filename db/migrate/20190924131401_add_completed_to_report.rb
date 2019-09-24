class AddCompletedToReport < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :completed, :boolean, default: false
  end
end
