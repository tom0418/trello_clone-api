# frozen_string_literal: true

module AuthToken
  ALGORITHM = 'HS256'

  def generate_jwt
    JWT.encode(payload, secret_key, ALGORITHM, header_fields)
  end

  private

  def payload
    {
      exp: exp_payload,
      iat: iat_payload,
      sub: sub_payload
    }
  end

  def secret_key
    Rails.application.credentials.secret_key_base
  end

  def header_fields
    {
      alg: 'HS256',
      typ: 'JWT'
    }
  end

  def exp_payload
    Time.now.to_i + 3600
  end

  def iat_payload
    Time.now.to_i
  end

  def sub_payload
    'account'
  end
end
