module Promisepay
  # Configuration options for {Client}, defaulting to values in {Default}.
  module Configurable
    # @!attribute api_domain
    #   @return [String] Promisepay API domain name. default: api.promisepay.com
    # @!attribute environment
    #   @see http://docs.promisepay.com/v2.2/docs/environments
    #   @return [String] Promisepay environment. default: test
    # @!attribute token
    #   @see http://docs.promisepay.com/v2.2/docs/overview-2
    #   @return [String] Promisepay token for Basic Authentication.
    # @!attribute username
    #   @see http://docs.promisepay.com/v2.2/docs/overview-2
    #   @return [String] Promisepay username for Basic Authentication.

    attr_accessor :api_domain, :environment, :token, :username

    class << self
      # List of configurable keys for {Promisepay::Client}.
      #
      # @return [Array] of option keys
      def keys
        @keys ||= [
          :environment,
          :api_domain,
          :token,
          :username
        ]
      end
    end

    # Reset configuration options to default values.
    def reset!
      Promisepay::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Promisepay::Default.options[key])
      end
      self
    end
    alias_method :setup, :reset!

    # API endpoint to be used by {Promisepay::Client}.
    # Built from {#environment} and {#api_domain}
    #
    # @return [String]
    def api_endpoint
      "https://#{@environment}.#{@api_domain}/"
    end
  end
end
