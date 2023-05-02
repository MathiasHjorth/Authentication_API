class AddDescAndPriceToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, 'description', :string, :limit => 50
    add_column :products, 'price',:decimal, :precision => 6, :scale => 2
  end
end
