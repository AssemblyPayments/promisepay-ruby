module Promisepay
  # Resource for the Payement Restrictions API
  class PaymentRestrictionResource < BaseResource
    def model
      Promisepay::PaymentRestriction
    end

    # List all payment restrictions
    #
    # @see https://reference.promisepay.com/#list-payment-restrictions
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 payment_restrictions. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    # @option options [String] :search Search string.
    # @option options [String] :user_id User ID to specify, if any.
    # @option options [String] :item_id Item ID to specify, if any.
    # @option options [String] :country Country to specify, if any.
    #
    # @return [Array<Promisepay::PaymentRestriction>] List all payment restrictions for a marketplace.
    def find_all(options = {})
      response = JSON.parse(@client.get('payment_restrictions', options).body)
      payment_restrictions = response.key?('payment_restrictions') ? response['payment_restrictions'] : []
      payment_restrictions.map { |attributes| Promisepay::PaymentRestriction.new(@client, attributes) }
    end

    # Get a single payment restriction for a marketplace
    #
    # @see https://reference.prelive.promisepay.com/#show-payment-restriction
    #
    # @param id [String] Marketplace PaymentRestriction ID.
    #
    # @return [Promisepay::PaymentRestriction]
    def find(id)
      response = JSON.parse(@client.get("payment_restrictions/#{id}").body)
      Promisepay::PaymentRestriction.new(@client, response['payment_restrictions'])
    end
  end
end
