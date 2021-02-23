# frozen_string_literal: true

module Api
  module Auth
    class RegistrationsController < Devise::RegistrationsController
      skip_before_action :process_token

      def create
        form = AccountForm.new(sign_up_params)
        account = form.build
        account.save!
        render json: account, status: :created
      end

      private

      def sign_up_params
        params.require(:account).permit(:email, :password, :password_confirmation, :nickname)
      end
    end
  end
end
