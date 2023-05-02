class DisallowNullsOnUserIdAndProductId < ActiveRecord::Migration[7.0]
  def change
    change_column :shopping_baskets, :product_id, :integer, null: false
    change_column :shopping_baskets, :user_id, :integer, null: false
  end
end
