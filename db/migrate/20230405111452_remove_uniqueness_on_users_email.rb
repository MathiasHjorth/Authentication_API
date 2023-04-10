class RemoveUniquenessOnUsersEmail < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :email, :string, unique: false
  end
end
