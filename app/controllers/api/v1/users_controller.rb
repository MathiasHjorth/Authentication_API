class Api::V1::UsersController < Devise::RegistrationsController
  include RackSessionFixController
  respond_to :json

  #POST
  # sign up
  def create
    super
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
      render json: current_user, status: :created
    elsif resource.errors.any?
      render json: resource.errors, status: :unprocessable_entity
    else
      render json: {error_message: 'unknown error'}, status: :internal_server_error
    end

  end

end
