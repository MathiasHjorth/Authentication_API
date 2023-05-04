class Api::V1::UsersController < Devise::RegistrationsController
  include RackSessionFixController
  respond_to :json

  #POST
  # sign up
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  #DELETE
  # delete user
  def destroy
    super
  end


  private

  #overriding sign_up_params to include a name
  def sign_up_params
    params.require(:user).permit(:name, :email, :password)
  end

  #overriding respond_with to add custom behaviour
  def respond_with(resource, options = {})

    if resource.persisted?
      render json: {message: 'User registered'}, status: :ok
    elsif resource.errors.any?
      render json: resource.errors, status: :unprocessable_entity
    else
      render json: {error_message: 'unknown error'}, status: :internal_server_error
    end

  end

end
