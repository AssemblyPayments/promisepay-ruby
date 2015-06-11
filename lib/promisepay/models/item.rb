module Promisepay
  # Manage Items
  class Item < BaseModel
    # Update the attributes of an item.
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsiduseraction
    #
    # @param attributes [Hash] Item's attributes to be updated.
    #
    # @return [self]
    def update(attributes)
      response = JSON.parse(@client.patch("items/#{send(:id)}", attributes).body)
      @attributes = response['items']
      self
    end

    # Show the item status for a marketplace.
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidstatus
    #
    # @return [Hash]
    def status
      response = JSON.parse(@client.get("items/#{send(:id)}/status").body)
      response['items']
    end

    # Show the buyer detail for a single item for a marketplace.
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidbuyers
    #
    # @return [Promisepay::User]
    def buyer
      response = JSON.parse(@client.get("items/#{send(:id)}/buyers").body)
      Promisepay::User.new(@client, response['users'])
    end

    # Show the seller detail for a single item for a marketplace.
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidbuyers
    #
    # @return [Promisepay::User]
    def seller
      response = JSON.parse(@client.get("items/#{send(:id)}/sellers").body)
      Promisepay::User.new(@client, response['users'])
    end

    # Show the wire details for payment.
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidwire_details
    #
    # @return [Hash]
    def wire_details
      response = JSON.parse(@client.get("items/#{send(:id)}/wire_details").body)
      response['items']['wire_details']
    end

    # Show the bpay details details for payment.
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidbpay_details
    #
    # @return [Hash]
    def bpay_details
      response = JSON.parse(@client.get("items/#{send(:id)}/bpay_details").body)
      response['items']['bpay_details']
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidaction
    #
    # @return [Boolean]
    def make_payment(options = {})
      JSON.parse(@client.patch("items/#{send(:id)}/make_payment", options).body)
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidrequest_payment
    #
    # @return [Boolean]
    def request_payment(options = {})
      JSON.parse(@client.patch("items/#{send(:id)}/request_payment", options).body)
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidrequest_payment
    #
    # @return [Boolean]
    def release_payment(options = {})
      JSON.parse(@client.patch("items/#{send(:id)}/release_payment", options).body)
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidrequest_release
    #
    # @return [Boolean]
    def request_release(options = {})
      JSON.parse(@client.patch("items/#{send(:id)}/request_release", options).body)
      true
    end
  end
end
