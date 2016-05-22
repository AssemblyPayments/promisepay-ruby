module Promisepay
  # Resource for the Items API
  class ItemResource < BaseResource
    def model
      Promisepay::Item
    end

    # List all items for a marketplace
    #
    # @see https://reference.promisepay.com/#list-items
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
    # @see https://reference.promisepay.com/#show-item
    #
    # @param id [String] Marketplace item ID.
    #
    # @return [Promisepay::Item]
    def find(id, type = :full)
      case type
        when :full
          response = JSON.parse(@client.get("items/#{id}").body)
          Promisepay::Item.new(@client, response['items'])
        when :status
          response = JSON.parse(@client.get("items/#{id}/status").body)
          Promisepay::Item.new(@client, response['items'])
      end
    end

    # Create an item for a marketplace
    #
    # @see https://reference.promisepay.com/#create-item
    #
    # @param attributes [Hash] Item's attributes.
    #
    # @return [Promisepay::Item]
    def create(attributes)
      response = JSON.parse(@client.post('items', attributes).body)
      Promisepay::Item.new(@client, response['items'])
    end
  end
end
