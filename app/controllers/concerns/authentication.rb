# frozen_string_literal: true

module Authentication
  private

  def process_token
    authorization_header = request.headers['Authorization']
    return if authorization_header.blank?

    access_token = authorization_header.split[1]
    payload = decode(access_token).first
    @current_account_id = payload['sub']
  end

  def authenticate_account!
    head(:unauthorized) unless signed_in?
  end

  def current_account
    @current_account ||= super || Account.find_by(uuid: process_token)
  end

  def signed_in?
    current_account.present?
  end
end
