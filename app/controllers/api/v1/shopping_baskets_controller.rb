class Api::V1::ShoppingBasketsController < ApplicationController
  include JwtHelper
  include AuthHelper
  before_action :authenticate_user!
  respond_to :json

  #GET
  # gets the user's shopping basket
  def show
    @shopping_basket = ShoppingBasket.where(:user_id => current_user.id)

    if @shopping_basket.any? then
      render json: @shopping_basket.as_json(include: :product, only: :quantity), status: 200
    else
      render json: {status: 200, message: 'Shopping basket is empty'}, status: 200
    end

  end

  #POST
  # adds a product to shopping basket
  def create
    @basket_item = ShoppingBasket.new({ user_id: current_user.id, product_id: basket_item_params[:product_id], quantity: basket_item_params[:quantity]})

    if in_basket?(@basket_item)
      #this could make sense to isolate in a seperate method instead of in the create action
      @item_to_update = ShoppingBasket.find_by(user_id: current_user.id, product_id: @basket_item[:product_id])
      @item_to_update.update(:quantity => @item_to_update.quantity += @basket_item[:quantity].to_i)

      render json: {status: 200, message: 'Product was in shopping basket already. Product quantity was incremented accordingly'}, status: 200 and return
    end

    if @basket_item.save
      render json: {status: 201, message: 'Product successfully added to basket'}, status: 201
    else
      render json: {status: 500, message: 'Unknown error'}, status: 500 #not handled properly...
    end

  end


  #GET
  # deletes entirely a single product from shopping basket
  def delete

    if ShoppingBasket.exists?(user_id: current_user.id, product_id: params[:product_id]) then
      ShoppingBasket.delete_by(user_id: current_user.id, product_id: params[:product_id])
      render json: {status: 200, message: 'Successfully removed product'}, status: 200 and return
    else
      render json: {status: 400, message: 'Could not find product in basket'}, status: 400
    end

  end


  #DELETE
  # removes all products from shopping basket
  def destroy
    @items_to_destroy = ShoppingBasket.destroy_by(user_id: current_user.id)

    if @items_to_destroy.any?
      render json: {status: 200, message: 'Successfully removed all items from shopping basket'}, status: 200 and return
    end

    render json: {status: 200, message: 'Shopping basket is empty'}, status: 200
  end


  private
  def basket_item_params
    params.require(:data).permit(:product_id,:quantity)
  end

  #Checks if the product is already in the basket for the user in question
  def in_basket?(basket_item)
    ShoppingBasket.exists?(user_id: basket_item[:user_id], product_id: basket_item[:product_id])
  end

end
