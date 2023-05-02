class Api::V1::ProductsController < ApplicationController
  include JwtHelper
  before_action :authenticate_user!
  respond_to :json

  #GET
  # get all products
  def index
    #as fetching all products is an expensive operation
    # i'm implementing low-level caching to cache the response, using memoryStore as the storage facility
    # this caches data within the same ruby process only and within the API server

    #Setting the cache key, to include the value of the most recent updated row
    # allows for invalidating the cache, so that when updates are made to the products,
    # a new cache is generated to reflect the update, and keep the cache from going stale

    last_modified_product = Product.order(:updated_at).last
    last_modified_str = last_modified_product.updated_at.utc.to_s

    #using the fetch method passing a block, we will fetch the value, if the cache key exists
    # otherwise create the cache key and value pair, and return the value(s)

    @products = Rails.cache.fetch("all_products/#{last_modified_str}", expires_in: 15.minutes) do
      Product.all.to_a
    end

    render json: @products, status:200

  end


  private
  #For successful authentication, the Authorization header must include a valid JWT token.
  def authenticate_user!
    unless current_user
      render json: {status: 401, error_message: 'An active login session is required to access this endpoint'}, status: :unauthorized
    end
  end

end
