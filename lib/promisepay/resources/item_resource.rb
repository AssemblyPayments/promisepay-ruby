module Promisepay
  # Resource for the Items API
  class ItemResource < BaseResource
    def model
      Promisepay::Item
    end

    # List all items for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/items
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 items. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::Item>] List all items for a marketplace.
    def find_all(options = {})
      response = JSON.parse(@client.get('items', options).body)
      items = response.key?('items') ? response['items'] : []
      items.map { |attributes| Promisepay::Item.new(@client, attributes) }
    end

    # Get a single item for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsid
    #
    # @param id [String] Marketplace item ID.
    #
    # @return [Promisepay::Item]
    def find(id)
      response = JSON.parse(@client.get("items/#{id}").body)
      Promisepay::Item.new(@client, response['items'])
    end

    # Create an item for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/items-1
    #
    # @param attributes [Hash] Item's attributes.
    #
    # @return [Promisepay::Item]
    def create(attributes)
      response = JSON.parse(@client.post('items', attributes).body)
      Promisepay::Item.new(@client, response['items'])
    end

    # Delete an item for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/items-2
    #
    # @param id [String] Marketplace item ID.
    #
    # @return [Boolean]
    def delete(id)
      @client.delete("items/#{id}")
      true
    end
  end
end
