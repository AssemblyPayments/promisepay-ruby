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

    # Get fees associated to the item.
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidfees
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 fees. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::Fee>]
    def fees(options = {})
      response = JSON.parse(@client.get("items/#{send(:id)}/fees", options).body)
      fees = response.key?('fees') ? response['fees'] : []
      fees.map { |attributes| Promisepay::Fee.new(@client, attributes) }
    end

    # Get historical transaction for the item.
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidtransactions
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 transactions. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::Transaction>]
    def transactions(options = {})
      response = JSON.parse(@client.get("items/#{send(:id)}/transactions", options).body)
      transactions = response.key?('transactions') ? response['transactions'] : []
      transactions.map { |attributes| Promisepay::Transaction.new(@client, attributes) }
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
      @client.patch("items/#{send(:id)}/make_payment", options).body
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidrequest_payment
    #
    # @return [Boolean]
    def request_payment(options = {})
      @client.patch("items/#{send(:id)}/request_payment", options).body
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidrequest_payment
    #
    # @return [Boolean]
    def release_payment(options = {})
      @client.patch("items/#{send(:id)}/release_payment", options).body
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidrequest_release
    #
    # @return [Boolean]
    def request_release(options = {})
      @client.patch("items/#{send(:id)}/request_release", options).body
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidacknowledge_wire
    #
    # @return [Boolean]
    def acknowledge_wire(options = {})
      @client.patch("items/#{send(:id)}/acknowledge_wire", options).body
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidacknowledge_paypal
    #
    # @return [Boolean]
    def acknowledge_paypal(options = {})
      @client.patch("items/#{send(:id)}/acknowledge_paypal", options).body
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidrevert_wire
    #
    # @return [Boolean]
    def revert_wire(options = {})
      @client.patch("items/#{send(:id)}/revert_wire", options).body
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidrequest_refund
    #
    # @return [Boolean]
    def request_refund(options = {})
      @client.patch("items/#{send(:id)}/request_refund", options).body
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidrefund
    #
    # @return [Boolean]
    def refund(options = {})
      @client.patch("items/#{send(:id)}/refund", options).body
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidcancel
    #
    # @return [Boolean]
    def cancel
      @client.patch("items/#{id}/cancel")
      true
    end
  end
end
