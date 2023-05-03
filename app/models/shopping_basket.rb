class ShoppingBasket < ApplicationRecord
  belongs_to :user
  belongs_to :product
  before_save :default_quantity_to_one



  private
  def default_quantity_to_one
    if quantity == 0 || quantity.nil? then
      self[:quantity] = 1
    end
  end


end
