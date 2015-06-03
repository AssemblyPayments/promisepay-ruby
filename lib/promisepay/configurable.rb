module Promisepay

  # Configuration options for {Client}, defaulting to values
  # in {Default}
  module Configurable
    # @!attribute [w] api_domain
    #   @return [String] Promisepay API domain name
    # @!attribute [w] environment
    #   @return [String] Promisepay environment to use ('test' or 'production')
    # @!attribute [w] token
    #   @return [String] Promisepay token for Basic Authentication
    # @!attribute username
    #   @return [String] Promisepay username (email address) for Basic Authentication


    attr_accessor :api_domain, :environment, :token, :username

    class << self

      # List of configurable keys for {Promisepay::Client}
      # @return [Array] of option keys
      def keys
        @keys ||= [
          :api_domain,
          :environment,
          :token,
          :username
        ]
      end
    end

    # Set configuration options using a block
    def configure
      yield self
    end

    # Reset configuration options to default values
    def reset!
      Promisepay::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Promisepay::Default.options[key])
      end
      self
    end
  end
end
