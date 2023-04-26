class Api::V1::ProductsController < ApplicationController
  include JwtHelper
  before_action :authenticate_user!

  #GET
  # get all products
  def index
    render json: Product.all, status:200
  end


  private
  #For successful authentication, the Authorization header must include a valid JWT token.
  def authenticate_user!
    unless current_user
      render json: {status: 401, error_message: 'An active login session is required to access this endpoint'}, status: :unauthorized
    end
  end

end
