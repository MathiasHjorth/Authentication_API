require "test_helper"

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  #The authenticateable functionality is obviously relevant for all authenticated controllers
  # ideally, testing of this functionality should be moved to a single test class to avoid bloat and redundancy
  def setup
    #Setting up a user
    post '/signup', params:{user:{name: 'Paul', email: 'user200@user.dk', password: '1234567'}}
    @jwt_token = @response['Authorization']
  end

  test "unauthenticated users should not have access to the controller" do
    get 'http://localhost:3000/api/v1/products', headers:{ Authorization: 'Bearer ij3o9028j89j2jfaojfd89920jfoijsxbgb09'}
    assert_response 401
  end

  test "users with valid jwt_tokens should have access to the controller" do
    get 'http://localhost:3000/api/v1/products', headers:{ Authorization: @jwt_token}
    assert_response 200
  end

  test "authenticated users should receive all products" do
    get 'http://localhost:3000/api/v1/products', headers:{ Authorization: @jwt_token}
    assert_response 200
    assert_equal Product.count, JSON.parse(@response.body).count, "products returned should be equal to the amount in the database"
  end

end
