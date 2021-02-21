# frozen_string_literal: true

module Api
  module Auth
    class SessionsController < Devise::SessionsController
      skip_before_action :process_token

      def create
        @account = Account.find_for_database_authentication(login: sign_in_params[:login])
        raise(ActionController::BadRequest) unless allow_login?

        access_token = current_account.generate_jwt
        render json: access_token.to_json, status: :created
      end

      private

      def allow_login?
        @account.present? && @account.valid_password?(sign_in_params[:password])
      end
    end
  end
end
