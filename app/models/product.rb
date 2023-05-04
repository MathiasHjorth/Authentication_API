class Product < ApplicationRecord
  has_many :shopping_baskets
  has_many :orders
end
