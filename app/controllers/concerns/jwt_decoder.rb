# frozen_string_literal: true

module JwtDecoder
  extend ActiveSupport::Concern

  ALGORITHM = { algorithm: 'HS256' }.freeze

  def jwt_payload!
    decode.first
    raise(JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError)
  end

  private

  def decode
    JWT.decode(access_token, secret_key, true, ALGORITHM)
  end

  def access_token
    request.headers['Authorization'].split[1]
  end

  def secret_key
    Rails.application.secrets.secret_key_base
  end
end
