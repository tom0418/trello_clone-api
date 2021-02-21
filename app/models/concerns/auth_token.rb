# frozen_string_literal: true

module AuthToken
  ALGORITHM = 'HS256'

  def generate_jwt
    JWT.encode(payload, secret_key, ALGORITHM, header_fields)
  end

  private

  def payload
    authenticate_at = Time.now.to_i

    {
      exp: authenticate_at + 3600,
      iat: authenticate_at,
      sub: uuid
    }
  end

  def secret_key
    Rails.application.secrets.secret_key_base
  end

  def header_fields
    {
      alg: 'HS256',
      typ: 'JWT'
    }
  end
end
