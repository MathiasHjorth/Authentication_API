# frozen_string_literal: true

module JwtHelper
  extend ActiveSupport::Concern

  def get_user_from_token
    user = JWT.decode(request.headers['Authorization'].split(' ')[1],ENV['DEVISE_JWT_SECRET_KEY'])
  end

  def get_payload_from_token
    payload = JWT.decode(request.headers['Authorization'].split(' ')[1],ENV['DEVISE_JWT_SECRET_KEY'])[0]
  end

  def jwt_revoked?
    request_payload = get_payload_from_token
    user = User.find(request_payload['sub'].to_i) #sub being id
    user.jti != request_payload['jti']
  end

end
