# frozen_string_literal: true

module Api
  module Auth
    class SessionsController < Devise::SessionsController
      prepend_before_action :verify_signed_out_user, only: :destroy

      skip_before_action :authenticate_account!, only: %i[create]

      def create
        @account = Account.find_for_database_authentication(login: sign_in_params[:login])
        raise(ActionController::BadRequest, 'aaa') unless allow_login?

        access_token = @account.generate_jwt
        @account.update_attribute(:access_token, access_token) # rubocop:disable Rails/SkipsModelValidations

        render json: @account, status: :created
      end

      def destroy
        current_account.update_attribute(:access_token, nil) # rubocop:disable Rails/SkipsModelValidations
        head(:no_content)
      end

      private

      def allow_login?
        @account.present? && @account.valid_password?(sign_in_params[:password])
      end

      def verify_signed_out_user
        respond_to_on_destroy unless signed_in?
      end

      def respond_to_on_destroy
        raise(ActionController::BadRequest)
      end
    end
  end
end
