# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |e|
      res = ErrorHandlerHelper.new(e, logger).response
      render json: res, status: status
    end
  end

  class ErrorHandlerHelper
    attr_reader :exception, :logger

    def initialize(exception, logger)
      @exception = exception
      @logger = logger

      log
    end

    def response
      response_format
    end

    private

    def response_format
      status == 422 ? form_validator_format : normal_format
    end

    def form_validator_format
      active_model_errors = exception.record.errors

      {
        errors: active_model_errors.details.flat_map do |attribute, attribute_errors|
          attribute_errors.map do |e|
            {
              code: status,
              field: attribute,
              title: response_title,
              sub_code: e[:error]
            }
          end
        end
      }
    end

    def normal_format
      {
        errors: [
          {
            code: status,
            title: response_title,
            sub_code: exception.message
          }
        ]
      }
    end

    def bad_request
      [ActionController::BadRequest, ActionController::ParameterMissing]
    end

    def unauthorized
      [JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError]
    end

    def not_found
      [ActionController::RoutingError, ActiveRecord::RecordNotFound]
    end

    def unprocessable_entity
      [ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique]
    end

    def status
      case exception
      when *bad_request then 400
      when *unauthorized then 401
      when *not_found then 404
      when *unprocessable_entity then 422
      else 500
      end
    end

    def response_title
      Rack::Utils::HTTP_STATUS_CODES[status]
    end

    def log
      logger.error(exception)
      logger.error(exception.backtrace.join('\n'))
    end
  end
end
