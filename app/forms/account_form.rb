# frozen_string_literal: true

class AccountForm < BaseForm
  attr_accessor :email, :password, :password_confirmation, :nickname, :uuid

  def initialize(params)
    super()
    @params = params
  end

  def build
    account = Account.new(@params)
    account.uuid = SecureRandom.uuid
    account.build_user

    account
  end

  private

  def account_uuid
    params[:uuid] ||= SecureRandom.uuid
  end

  attr_accessor :account
end
