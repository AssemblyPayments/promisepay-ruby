module Promisepay
  # Manage Card accounts
  class CardAccount < Account
    # Get the user the card account belongs to.
    #
    # @see http://docs.promisepay.com/v2.2/docs/card_accountsidusers
    #
    # @return [Promisepay::User]
    def user
      response = JSON.parse(@client.get("card_accounts/#{send(:id)}/users").body)
      Promisepay::User.new(@client, response['users'])
    end

    # Deletes a card account for a user on a marketplace.
    # Sets the account to in-active.
    #
    # @see http://docs.promisepay.com/v2.2/docs/card_accountsid
    #
    # @return [Boolean]
    def deactivate!
      @client.delete("card_accounts/#{id}")
      @attributes['active'] = false
      true
    end
  end
end
