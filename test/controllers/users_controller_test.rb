require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
  end

  test "should receive an authentication token on successful sign up" do

  end

  test "should not register a user if password length < 6" do
    post '/signup', params:{
      user:
      {
        name: 'John', email: 'user10@user.dk', password: '12345'
      }
    }
    assert_response 422, 'users should not be registered with passwords shorter than 6 characters'
  end

  test "should not register a user if email is not unique" do
    post '/signup', params:{
      user:
        {
          name: 'Paul', email: 'user1@user.dk', password: '123456'
        }
    }
    assert_response 422, 'users should not be registered with non-unique emails'
  end

  test "request params not formed according to sign_up_params should fail" do
    assert_raises ActionController::ParameterMissing do
      post '/signup', params:{
        usera:
          {
            name: 'Paul', email: 'user10@user.dk', password: '123456'
          }
      }
    end
  end

end
