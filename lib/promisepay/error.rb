module Promisepay
  # Custom error class for rescuing from all Promisepau errors
  class Error < StandardError
    # Returns the appropriate Promisepay::Error subclass based on status
    #
    # @param [Faraday::Response] response Faraday HTTP response
    # @return [Promisepay::Error]
    def self.from_response(response)
      klass = case response.status
              when 400      then Promisepay::BadRequest
              when 401      then Promisepay::Unauthorized
              when 403      then Promisepay::Forbidden
              when 404      then Promisepay::NotFound
              when 405      then Promisepay::MethodNotAllowed
              when 406      then Promisepay::NotAcceptable
              when 409      then Promisepay::Conflict
              when 422      then Promisepay::UnprocessableEntity
              when 400..499 then Promisepay::ClientError
              when 500      then Promisepay::InternalServerError
              when 501      then Promisepay::NotImplemented
              when 502      then Promisepay::BadGateway
              when 503      then Promisepay::ServiceUnavailable
              when 500..599 then Promisepay::ServerError
              end
      (klass) ? klass.new(response) : new(response)
    end

    def initialize(response = nil)
      @response = response
      super(build_error_message)
    end

    private

    def build_error_message
      return nil if @response.nil? || @response.body.nil?

      json_response = JSON.parse(@response.body)
      message = ''
      message << json_response['message'] if json_response.key?('message')
      if json_response.key?('errors')
        message << json_response['errors'].map{|attribute, content| "#{attribute}: #{content.join(", ")}"}.join(", ")
      end

      message
    end
  end

  # Raised on errors in the 400-499 range
  class ClientError < Error; end

  # Raised when Promisepay returns a 400 HTTP status code
  class BadRequest < ClientError; end

  # Raised when Promisepay returns a 401 HTTP status code
  class Unauthorized < ClientError; end

  # Raised when Promisepay returns a 403 HTTP status code
  class Forbidden < ClientError; end

  # Raised when Promisepay returns a 404 HTTP status code
  class NotFound < ClientError; end

  # Raised when Promisepay returns a 405 HTTP status code
  class MethodNotAllowed < ClientError; end

  # Raised when Promisepay returns a 406 HTTP status code
  class NotAcceptable < ClientError; end

  # Raised when Promisepay returns a 409 HTTP status code
  class Conflict < ClientError; end

  # Raised when Promisepay returns a 422 HTTP status code
  class UnprocessableEntity < ClientError; end

  # Raised on errors in the 500-599 range
  class ServerError < Error; end

  # Raised when Promisepay returns a 500 HTTP status code
  class InternalServerError < ServerError; end

  # Raised when Promisepay returns a 501 HTTP status code
  class NotImplemented < ServerError; end

  # Raised when Promisepay returns a 502 HTTP status code
  class BadGateway < ServerError; end

  # Raised when Promisepay returns a 503 HTTP status code
  class ServiceUnavailable < ServerError; end
end
