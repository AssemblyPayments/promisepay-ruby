module Promisepay
  # Resource for the PaypalAccounts API
  class PaypalAccountResource < AccountResource
    def model
      Promisepay::PaypalAccount
    end

    # Get paypal account for a user on a marketplace.
    #
    # @see https://reference.promisepay.com/#show-paypal-account
    #
    # @param id [String] Paypal Account ID.
    #
    # @return [Promisepay::PaypalAccount]
    def find(id)
      response = JSON.parse(@client.get("paypal_accounts/#{id}").body)
      Promisepay::PaypalAccount.new(@client, response['paypal_accounts'])
    end

    # Create a Paypal account for a user on a marketplace.
    #
    # @see https://reference.promisepay.com/#create-paypal-account
    #
    # @param attributes [Hash] Paypal Account's attributes.
    #
    # @return [Promisepay::PaypalAccount]
    def create(attributes)
      response = JSON.parse(@client.post('paypal_accounts', attributes).body)
      Promisepay::PaypalAccount.new(@client, response['paypal_accounts'])
    end
  end
end
