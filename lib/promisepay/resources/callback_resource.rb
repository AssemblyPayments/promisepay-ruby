module Promisepay
  # Resource for the Users API
  class CallbackResource < BaseResource
    def model
      Promisepay::Callback
    end

    # List all callbacks for a marketplace
    #
    # @see https://reference.promisepay.com/#list-callbacks
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 callbacks. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::Callback>] List all callbacks for a marketplace.
    def find_all(options = {})
      response = JSON.parse(@client.get('callbacks', options).body)
      callbacks = response.key?('callbacks') ? response['callbacks'] : []
      callbacks.map { |attributes| Promisepay::Callback.new(@client, attributes) }
    end

    # Get a callback
    #
    # @see https://reference.promisepay.com/#show-callback
    #
    # @param id [String] Marketplace callback ID.
    #
    # @return [Promisepay::Callback]
    def find(id)
      response = JSON.parse(@client.get("callbacks/#{id}").body)
      Promisepay::Callback.new(@client, response['callbacks'])
    end

    # Create a new callback for a marketplace
    #
    # @see https://reference.promisepay.com/#create-callback
    #
    # @param attributes [Hash] Callback's attributes.
    #
    # @return [Promisepay::Callback]
    def create(attributes)
      response = JSON.parse(@client.post('callbacks', attributes).body)
      Promisepay::Callback.new(@client, response['callbacks'])
    end

    # Update a user for a marketplace
    #
    # @see https://reference.promisepay.com/#update-callback
    #
    # @param attributes [Hash] Callback's attributes.
    #
    # @return [Promisepay::Callback]
    def update(attributes)
      response = JSON.parse(@client.patch("callbacks/#{attributes[:id]}", attributes).body)
      Promisepay::Callback.new(@client, response['callbacks'])
    end
  end
end
