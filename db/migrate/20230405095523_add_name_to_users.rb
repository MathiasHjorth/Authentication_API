class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    change_column :users, :email, :string, unique: true
  end
end
