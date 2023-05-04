class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|

      t.integer :user_id, null: false

      t.foreign_key :users, column: :user_id, primary_key: 'id'

      t.timestamps
    end
  end
end
