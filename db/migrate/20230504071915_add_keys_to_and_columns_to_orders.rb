class AddKeysToAndColumnsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, 'product_id', :integer, null: false
    add_column :orders, 'price_at_checkout', :decimal,precision: 6, scale: 2, null: false
    add_column :orders, 'product_quantity', :integer, null: false
    add_column :orders, 'order_number', :integer, null: false

  end
end
