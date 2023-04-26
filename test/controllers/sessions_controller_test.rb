require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    # Setting up a user
    post '/signup', params:{user:{name: 'John', email: 'user10@user.dk', password: '1234567'}}
  end

  test "should return an authorization header on successful logins" do
    post '/login', params:{
      user:{
        email: 'user10@user.dk',
        password: '1234567'
      }
    }
    assert_response 200, 'should get a 200 response on successful logins'
    assert_equal false, @response['Authorization'].nil?
  end

  test "request params not formed according to sign_in_params should fail" do
    assert_raises ActionController::ParameterMissing do
      post '/login', params:{
        usera:
          {
            email: 'user10@user.dk'
          }
      }
    end
  end




end
