module Promisepay
  # Resource for the Configuration API
  class ConfigurationResource < BaseResource
    def model
      Promisepay::Configuration
    end

    # List all configuration for a marketplace
    #
    # @see https://reference.promisepay.com/#list-configurations
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 items. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    # @option options [String] :search Search string.
    # @option options [String] :user_id User ID to specify, if any.
    # @option options [String] :item_id Item ID to specify, if any.
    # @option options [String] :country Country to specify, if any.
    #
    # @return [Array<Promisepay::Configuration>] List all configurations for a marketplace.
    def find_all(options = {})
      response = JSON.parse(@client.get('configurations', options).body)
      configurations = response.key?('feature_configurations') ? response['feature_configurations'] : []
      configurations.map { |attributes| Promisepay::Configuration.new(@client, attributes) }
    end

    # Get a single configuration for a marketplace
    #
    # @see https://reference.promisepay.com/#show-configuration
    #
    # @param id [String] Marketplace configuration ID.
    #
    # @return [Promisepay::Configuration]
    def find(id)
      response = JSON.parse(@client.get("configurations/#{id}").body)
      if response['feature_configurations'].nil? || response['feature_configurations'].empty?
        nil
      else
        Promisepay::Configuration.new(@client, response['feature_configurations'])
      end
    end

    # Create an configuration for a marketplace
    #
    # @see https://reference.prelive.promisepay.com/#create-configuration
    #
    # @param attributes [Hash] Configuration's attributes.
    #
    # @return [Promisepay::Configuration]
    def create(attributes)
      response = JSON.parse(@client.post('configurations', attributes).body)
      Promisepay::Configuration.new(@client, response['feature_configurations'])
    end
  end
end
