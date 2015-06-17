module Promisepay
  # Manage Paypal accounts
  class PaypalAccount < Account
    # Get the user the paypal account belongs to.
    #
    # @see http://docs.promisepay.com/v2.2/docs/paypal_accountsidusers
    #
    # @return [Promisepay::User]
    def user
      response = JSON.parse(@client.get("paypal_accounts/#{send(:id)}/users").body)
      Promisepay::User.new(@client, response['users'])
    end

    # Deletes a Paypal account for a user on a marketplace.
    # Sets the account to in-active.
    #
    # @see http://docs.promisepay.com/v2.2/docs/paypal_accountsid
    #
    # @return [Boolean]
    def deactivate
      @client.delete("paypal_accounts/#{id}")
      @attributes['active'] = false
      true
    end
  end
end
