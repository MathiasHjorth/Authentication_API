class AddFkOnOrders < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :orders, :products, column: 'product_id', primary_key: 'id'
  end
end
