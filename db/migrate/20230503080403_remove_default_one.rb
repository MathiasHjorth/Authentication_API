class RemoveDefaultOne < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:shopping_baskets, :quantity, nil)
  end
end
