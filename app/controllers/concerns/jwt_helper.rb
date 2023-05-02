# frozen_string_literal: true

module JwtHelper
  extend ActiveSupport::Concern

  def get_user_id_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],ENV['DEVISE_JWT_SECRET_KEY'])
    user_id = jwt_payload[0]['sub'].to_i
    return user_id
  end

  def get_payload_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],ENV['DEVISE_JWT_SECRET_KEY'])[0]
  end

  def jwt_revoked?
    jwt_payload = get_payload_from_token
    user = User.find(jwt_payload['sub'].to_i)
    user.jti != jwt_payload['jti']
  end

end
