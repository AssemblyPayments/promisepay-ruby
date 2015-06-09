module Promisepay
  # Resource for the CardAccounts API
  class CardAccountResource < AccountResource
    def model
      Promisepay::CardAccount
    end

    # Get card account for a user on a marketplace.
    #
    # @see http://docs.promisepay.com/v2.2/docs/card_accountsid-1
    #
    # @param id [String] Bank Account ID.
    #
    # @return [Promisepay::CardAccount]
    def find(id)
      response = JSON.parse(@client.get("card_accounts/#{id}").body)
      Promisepay::CardAccount.new(@client, response['card_accounts'])
    end

    # Create a card account for a user on a marketplace.
    #
    # @see http://docs.promisepay.com/v2.2/docs/card_accountsid-2
    #
    # @param attributes [Hash] Bank Account's attributes.
    #
    # @return [Promisepay::CardAccount]
    def create(attributes)
      response = JSON.parse(@client.post('card_accounts', attributes).body)
      Promisepay::CardAccount.new(@client, response['card_accounts'])
    end
  end
end
