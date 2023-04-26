class Api::V1::SessionsController < Devise::SessionsController
  include ActionController::MimeResponds
  include JwtHelper
  respond_to :json

  #POST
  # login
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  #DELETE
  # logout
  def destroy
    #We need to provide a user which we can extract from the Authorization request header.
    # Default behaviour of destroy is to sign out all users in the system at once, which is not what we want.
    # By doing this, we allow other users to remain active, and only logout the one making the request.

    # The sign_out method automatically fires our JTIMatcher strategy, and changes the value of the jti column on the user.
    # Therefore it's essential to call.
    user_payload = get_user_from_token
    user = User.where(id: user_payload[0]['sub'].to_i)
    sign_out(user)
  end


  private

  def respond_with(resource, options = {})
    if warden.authenticated? then
      render json: {status: 200, message: 'Login succeeded'}, status: 200
    else
      render json: {status: 422, message: 'Login failed, wrong password or email'}, status: 422
    end
  end

  def respond_to_on_destroy
    if jwt_revoked? then
      render json: {status: 400, error_message: 'User already logged out'}, status: 400
    else
      render json: {status: 200, message: 'User successfully logged out'}, status: 200
    end
  end



  protected

  def sign_in_params
    params.require(:user).permit(:email,:password)
  end

end
