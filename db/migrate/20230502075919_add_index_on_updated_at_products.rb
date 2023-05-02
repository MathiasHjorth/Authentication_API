class AddIndexOnUpdatedAtProducts < ActiveRecord::Migration[7.0]
  def change
    add_index :products, :updated_at
  end
end
