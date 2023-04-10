class User < ApplicationRecord

  include Devise::JWT::RevocationStrategies::JTIMatcher
  #Simply put the JTIMatcher strategy relies on comparing the database persisted value
  # of the jti column for a user with the incoming jti value in the jwt payload
  # if they don't match, that means the token has been revoked, and access will be denied. Vice versa.
  # Tokens are dispatched on registrations by default and on login, as defined in the Devise initializer.
  # On revocation the jti value for a user will be updated, this is handled automatically by the 'devise-jwt' gem.


  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self


  validate :email_unique #,:password_length


  private
  #these validations are already handled automatically because:
  # email has been set to unique: true
  # password has been configged to require length = 6..25 in the Devise initializer
  # this is solely for demonstration purposes, on how i would add further validation
  def email_unique
    if User.exists?(email: email) then
      errors.add(:email, message: 'email must be unique')
    end
  end

  def password_length
    if password.length < 6 then
      errors.add(:password, message: 'password must be atleast 6 characters')
    end
  end

end
