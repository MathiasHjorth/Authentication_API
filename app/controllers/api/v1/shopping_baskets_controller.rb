class Api::V1::ShoppingBasketsController < ApplicationController
  include JwtHelper
  before_action :authenticate_user!
  respond_to :json

  #GET
  # gets the user's shopping basket
  def show

  end

  #POST
  # adds product to shopping basket
  def create

    @current_user_id = get_user_id_from_token

    @basket_item = ShoppingBasket.new({ user_id: @current_user_id, product_id: basket_item_params[:product_id], quantity: basket_item_params[:quantity]})

    if in_basket?(@basket_item)
      @fetched_item = ShoppingBasket
      @fetched_item.update(:quantity => @fetched_item.quantity += @basket_item[:quantity])

      render json: {status: 200, message: 'Product is already in basket. Product quantity has been incremented'}, status: 200 and return
    end

    if @basket_item.save
      render json: {status: 201, message: 'Product successfully added to basket'}, status: 201
    else
      render json: {status: 500, message: 'Unknown error'}, status: 500 #not handled properly...
    end

  end

  #DELETE
  # removes all products from shopping basket
  def destroy

  end


  private
  #For successful authentication, the Authorization header must include a valid JWT token.
  def authenticate_user!
    unless current_user
      render json: {status: 401, error_message: 'An active login session is required to access this endpoint'}, status: :unauthorized
    end
  end

  def basket_item_params
    params.require(:data).permit(:product_id,:quantity)
  end

  def in_basket?(basket_item)
    #checking if the product is already in the basket for the user in question
    ShoppingBasket.exists?(user_id: basket_item[:user_id], product_id: basket_item[:product_id])
  end


end
