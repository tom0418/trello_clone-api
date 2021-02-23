# frozen_string_literal: true

class AccountForm < BaseForm
  attr_accessor :email, :password, :password_confirmation, :nickname, :uuid, :access_token

  def initialize(params)
    super()
    @params = params
  end

  def build
    account = Account.new(@params)
    account.uuid = SecureRandom.uuid
    account.access_token = account.generate_jwt
    account.build_user

    account
  end

  private

  attr_accessor :account
end
