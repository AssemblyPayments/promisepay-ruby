module Promisepay
  # Manage Wallet Accounts
  class WalletAccount < BaseModel
    # Withdraw funds from a Wallet Account to a specified disbursement account.
    #
    # @see https://reference.promisepay.com/#withdraw-funds
    #
    # @param options [Hash] Optional options.
    # @option options [String] :account_id Account to withdraw to.
    # @option options [Integer] :amount Amount (in cents) to withdraw.
    #
    # @return [Hash]
    def withdraw(options = {})
      response = JSON.parse(@client.post("wallet_accounts/#{send(:id)}/withdraw", options).body)
      response.key?('disbursements') ? response['disbursements'] : {}
    end

    # Deposit funds to a Wallet Account from a specified payment account.
    #
    # @see https://reference.promisepay.com/#deposit-funds
    #
    # @param options [Hash] Optional options.
    # @option options [String] :account_id Account to deposit from.
    # @option options [Integer] :amount Amount (in cents) to deposit.
    #
    # @return [Hash]
    def deposit(options = {})
      response = JSON.parse(@client.post("wallet_accounts/#{send(:id)}/deposit", options).body)
      response.key?('disbursements') ? response['disbursements'] : {}
    end

    # Show the User the Wallet Account is associated with
    #
    # @return [Promisepay::User]
    def user
      response = JSON.parse(@client.get("wallet_accounts/#{send(:id)}/users").body)
      response.key?('users') ? Promisepay::User.new(@client, response['users']) : nil
    end
  end
end
