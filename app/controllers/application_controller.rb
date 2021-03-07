# frozen_string_literal: true

class ApplicationController < ActionController::API
  respond_to :json

  include Authentication
  include ErrorHandler
  include JwtDecoder

  before_action :process_token
  before_action :authenticate_account!
end
