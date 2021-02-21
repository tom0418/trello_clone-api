# frozen_string_literal: true

class ApplicationController < ActionController::API
  respond_to :json

  before_action :process_token

  include ErrorHandler
  include JwtDecoder

  private

  def process_token
    jwt_payload! if access_token.present?
    @current_account_id = jwt_payload['sub']
  end

  def authenticate_account!
    head(:unauthorized) unless signed_in?
  end

  def sign_in?
    @current_account_id.present?
  end

  def current_account
    @current_account ||= super || Account.find(@current_account_id)
  end
end
