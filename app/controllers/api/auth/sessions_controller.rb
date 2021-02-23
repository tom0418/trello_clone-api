# frozen_string_literal: true

module Api
  module Auth
    class SessionsController < Devise::SessionsController
      skip_before_action :process_token

      def create
        @account = Account.find_for_database_authentication(login: sign_in_params[:login])
        raise(ActionController::BadRequest) unless allow_login?

        access_token = @account.generate_jwt
        @account.update_attribute(:access_token, access_token) # rubocop:disable Rails/SkipsModelValidations

        render json: @account, status: :created
      end

      private

      def allow_login?
        @account.present? && @account.valid_password?(sign_in_params[:password])
      end
    end
  end
end
