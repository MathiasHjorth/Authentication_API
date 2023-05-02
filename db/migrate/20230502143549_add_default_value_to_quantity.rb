class AddDefaultValueToQuantity < ActiveRecord::Migration[7.0]
  def change
    change_column :shopping_baskets, :quantity, :integer, default: 1
  end
end
