class Order < ApplicationRecord
  #This association type seems unintuitive at first, but since quantity of products is an attribute, it makes sense.
  belongs_to :product
  belongs_to :user

end
