module Promisepay
  # Default configuration options for {Client}
  module Default
    # Default API domain
    API_DOMAIN = 'api.promisepay.com'.freeze

    # Default environment
    ENVIRONMENT = 'test'.freeze

    class << self
      # Configuration options.
      #
      # @return [Hash]
      def options
        Hash[Promisepay::Configurable.keys.map { |key| [key, send(key)] }]
      end

      # Default environment from ENV or {ENVIRONMENT}.
      #
      # @return [String]
      def environment
        ENV['PROMISEPAY_ENVIRONMENT'] || ENVIRONMENT
      end

      # Default API domain from ENV or {API_DOMAIN}.
      #
      # @return [String]
      def api_domain
        ENV['PROMISEPAY_API_DOMAIN'] || API_DOMAIN
      end

      # Default token from ENV.
      #
      # @return [String]
      def token
        ENV['PROMISEPAY_TOKEN']
      end

      # Default username from ENV.
      #
      # @return [String]
      def username
        ENV['PROMISEPAY_USERNAME']
      end
    end
  end
end
