# frozen_string_literal: true

module Api
  module Auth
    class RegistrationsController < Devise::RegistrationsController
      def create
        account = Account.new(sign_up_params)
        account.build_user

        account.save!
        access_token = account.generate_jwt
        render json: access_token
      end

      private

      def sign_up_params
        params.require(:account).permit(:email, :password, :password_confirmation, :nickname, :uuid)
      end
    end
  end
end
