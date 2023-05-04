class ChangeOrderNumberToString < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :order_number, :string, null: false
  end
end
