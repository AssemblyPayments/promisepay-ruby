module Promisepay
  # Resource for the Users API
  class TokenResource < BaseResource
    def model
      Promisepay::Token
    end

    # Create a new token for an item
    #
    # @see http://docs.promisepay.com/v2.2/docs/request_session_token
    #
    # @param attributes [Hash] Token's attributes.
    #
    # @return [Promisepay::Token]
    def create(type = :session, attributes)
      case type
        when :session
          if attributes && attributes[:fee_ids] && attributes[:fee_ids].is_a?(Array)
            attributes[:fee_ids] = attributes[:fee_ids].join(",")
          end
          response = JSON.parse(@client.get('request_session_token', attributes).body)
          Promisepay::Token.new(@client, response.token)
      end
    end

  end
end
