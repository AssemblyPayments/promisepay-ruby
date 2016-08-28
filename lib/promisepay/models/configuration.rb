module Promisepay
  # Manage Configurations
  class Configuration < BaseModel
    # Update a configuration.
    #
    # @see https://reference.promisepay.com/#update-configuration
    #
    # @param attributes [Hash] Configuration's attributes to be updated.
    #
    # @return [self]
    def update(attributes)
      response = JSON.parse(@client.patch("configurations/#{send(:id)}", attributes).body)
      @attributes = response['feature_configurations']
      self
    end

    # Delete a specific Configuration
    #
    # @see https://reference.promisepay.com/#delete-configuration
    #
    # @return [Boolean]
    def delete
      @client.delete("configurations/#{id}")
      true
    end
  end
end
