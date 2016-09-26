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

    # When penny verification is enabled, this API call sends two penny transactions
    # to the specified bank account for verification.
    #
    # @see https://reference.promisepay.com/#send-penny-amount
    #
    # @return [BankAccount]
    def send_penny
      @client.patch("bank_accounts/#{send(:id)}/penny_send")
      Promisepay::BankAccount.new(@client, response['bank_accounts'])
    end

    # When penny verification is enabled, this API call verifies the two penny transactions
    # that were sent to a specified bank account using Send Penny Amount
    #
    # @see https://reference.promisepay.com/#verify-penny-amount
    #
    # @param amount_1 [Integer] first penny amount in cents; can range from 1 to 30 cents.
    # @param amount_2 [Integer] second penny amount in cents; can range from 1 to 30 cents.

    # @return [Booelan]
    def verify_penny(amount_1, amount_2)
      @client.patch("bank_accounts/#{send(:id)}/penny_send")
      true
    end
  end
end
