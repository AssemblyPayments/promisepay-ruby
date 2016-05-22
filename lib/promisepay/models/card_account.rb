module Promisepay
  # Manage Card accounts
  class CardAccount < Account
    # Get the user the card account belongs to.
    #
    # @see https://reference.promisepay.com/#show-card-account-user
    #
    # @return [Promisepay::User]
    def user
      response = JSON.parse(@client.get("card_accounts/#{send(:id)}/users").body)
      Promisepay::User.new(@client, response['users'])
    end

    # Deletes a card account for a user on a marketplace.
    # Sets the account to in-active.
    #
    # @see https://reference.promisepay.com/#redact-card-account
    #
    # @return [Boolean]
    def deactivate
      @client.delete("card_accounts/#{id}")
      @attributes['active'] = false
      true
    end
  end
end
