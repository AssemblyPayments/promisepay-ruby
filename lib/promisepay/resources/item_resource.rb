module Promisepay
  # Resource for the Items API
  class ItemResource < BaseResource
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
      response.key?('items') ? Promisepay::Item.new(@client, response['items']) : nil
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
      if response.key?('errors')
        nil
      else
        Promisepay::Item.new(@client, response['items'])
      end
    end

    # Delete an item for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/items-2
    #
    # @param id [String] Marketplace item ID.
    #
    # @return boolean
    def delete(id)
      response = JSON.parse(@client.delete("items/#{id}").body)
      response.key?('errors')
    end

    def method_missing(name, *args, &block)
      if Promisepay::Item.instance_methods.include?(name)
        Promisepay::Item.new(@client, id: args[0]).send(name, *args[1..-1])
      else
        super
      end
    end
  end
end
