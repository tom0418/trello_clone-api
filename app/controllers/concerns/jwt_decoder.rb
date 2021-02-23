# frozen_string_literal: true

module JwtDecoder
  extend ActiveSupport::Concern

  ALGORITHM = { algorithm: 'HS256' }.freeze

  def decode(access_token)
    JWT.decode(access_token, secret_key, true, ALGORITHM)
  end

  private

  def secret_key
    Rails.application.secrets.secret_key_base
  end
end
