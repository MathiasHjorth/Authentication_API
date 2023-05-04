class Api::V1::OrdersController < ApplicationController
  include JwtHelper
  include AuthHelper
  before_action :authenticate_user!
  respond_to :json


  #GET
  # returns all orders for a user
  def index

    @orders = Order.eager_load(:product).where(user_id: current_user.id)
    unless @orders.any? then
      render json: {status: 200, message: 'No previous orders were found',order_history: @orders}, status: 200 and return
    end

    #this majorly lags response beautifying, which could be implemented by fiddling with as_json
    # ultimately though, the data model provides everything needed to group orders, seeing what was in a particular order along with prices at checkout etc.
    render json: @orders.as_json(include: :product, only: [ :price_at_checkout, :product_quantity, :order_number]), status: 200
  end

  #POST
  # create an order, ie. checkout a user's shopping basket
  def create
    #needs error handling

    unless basket_empty?
      render json: {status: 404, message: 'Failed to checkout basket. Shopping basket is empty'}, status: 404 and return
    end

    @shopping_basket = ShoppingBasket.where(user_id: current_user.id)

    @new_order_number = generate_order_number(@shopping_basket)


    #Empty shopping basket for user, create orders and persist
    @shopping_basket.each do |basket_item|
      Order.create(
        {
                  user_id: basket_item.user.id,
                  product_id: basket_item.product.id,
                  price_at_checkout: basket_item.product.price,
                  product_quantity: basket_item.quantity,
                  order_number: @new_order_number
                })
    end

    ShoppingBasket.destroy_by(user_id: current_user.id)
    render json: {status: 200, message: "Successfully checked out shopping basked. Order was created order number #{@new_order_number}"}, status: 200

  end


  private

  #Generates a unique order_number
  def generate_order_number(shopping_basket)
    "#{current_user.id}-#{shopping_basket.to_a.count}-#{Time.current.strftime('%M%S%L').to_i}"
  end

  #Checks if the user's shopping basket is empty
  def basket_empty?
    ShoppingBasket.where(user_id: current_user.id).any?
  end

end
