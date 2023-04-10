class ChangeUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :email, :string, unique: false
    remove_index :users, :email
  end
end
