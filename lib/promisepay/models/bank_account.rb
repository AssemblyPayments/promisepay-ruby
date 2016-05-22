module Promisepay
  # Manage Bank accounts
  class BankAccount < Account
    # Get the user the bank account belongs to.
    #
    # @see https://reference.promisepay.com/#show-bank-account-user
    #
    # @return [Promisepay::User]
    def user
      response = JSON.parse(@client.get("bank_accounts/#{send(:id)}/users").body)
      Promisepay::User.new(@client, response['users'])
    end

    # Deletes a bank account for a user on a marketplace.
    # Sets the account to in-active.
    #
    # @see https://reference.promisepay.com/#redact-bank-account
    #
    # @param mobile_pin [String] Mobile PIN.
    #
    # @return [Boolean]
    def deactivate(mobile_pin)
      @client.delete("bank_accounts/#{id}", mobile_pin: mobile_pin)
      @attributes['active'] = false
      true
    end
  end
end
