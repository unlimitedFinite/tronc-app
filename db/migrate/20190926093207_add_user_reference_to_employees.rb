class AddUserReferenceToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_reference :employees, :user, index: true
  end
end
