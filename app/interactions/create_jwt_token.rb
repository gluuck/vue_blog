# frozen_string_literal: true

class CreateJwtToken < ActiveInteraction::Base
  SECRET_KEY = Rails.configuration.jwt_secret_key

  string :email
  string :password

  validate :check_user

  def execute
    return unless @user

    encode
  end

  private

  attr_reader :invalid

  def check_user
    @user ||= User.find_by(email:)&.authenticate(password)
    errors.add :invalid, :sign_in unless @user
  end

  def encode
    payload = { uid: @user.id, exp: Rails.configuration.jwt_token_expire_time.from_now.to_i }
    JWT.encode payload, SECRET_KEY, 'HS256'
  end
end
