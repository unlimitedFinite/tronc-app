class AddUserToTroncRecord < ActiveRecord::Migration[6.0]
  def change
    add_reference :tronc_records, :user, index: true
  end
end
