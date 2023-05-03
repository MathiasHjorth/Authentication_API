# frozen_string_literal: true

module AuthHelper
  #helper methods regarding authentication


  #For successful authentication, the Authorization header must include a valid JWT token.
  def authenticate_user!
    unless current_user
      render json: {status: 401, error_message: 'An active login session is required to access this endpoint'}, status: :unauthorized
    end
  end

end
