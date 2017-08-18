module Promisepay
  # Manage Transactions
  class Transaction < Account
    # Show the User associated with the Transaction.
    #
    # @see https://reference.promisepay.com/#show-transaction-user
    #
    # @return [Promisepay::User]
    def user
      response = JSON.parse(@client.get("transactions/#{send(:id)}/users").body)
      response.key?('users') ? Promisepay::User.new(@client, response['users']) : nil
    end

    # Gets a transactions fee details if applicable.
    #
    # @see https://reference.promisepay.com/#shows-transaction-fees
    #
    # @return [Promisepay::Fee]
    def fee
      response = JSON.parse(@client.get("transactions/#{send(:id)}/fees").body)
      response.key?('fees') ? Promisepay::Fee.new(@client, response['fees']) : nil
    end

    # Show the Bank Account associated with the Transaction.
    #
    # @see https://reference.promisepay.com/#show-transaction-bank-account
    #
    # @return [Promisepay::BankAccount]
    def bank_account
      response = JSON.parse(@client.get("transactions/#{send(:id)}/bank_accounts").body)
      response.key?('bank_accounts') ? Promisepay::BankAccount.new(@client, response['bank_accounts']) : nil
    end

    # Show the Card Account associated with the Transaction.
    #
    # @see https://reference.promisepay.com/#show-transaction-card-account
    #
    # @return [Promisepay::CardAccount]
    def card_account
      response = JSON.parse(@client.get("transactions/#{send(:id)}/card_accounts").body)
      response.key?('card_accounts') ? Promisepay::CardAccount.new(@client, response['card_accounts']) : nil
    end

    # Show the Paypal Account associated with the Transaction.
    #
    # @see https://reference.promisepay.com/#show-transaction-paypal-account
    #
    # @return [Promisepay::PaypalAccount]
    def paypal_account
      response = JSON.parse(@client.get("transactions/#{send(:id)}/paypal_accounts").body)
      response.key?('paypal_accounts') ? Promisepay::PaypalAccount.new(@client, response['paypal_accounts']) : nil
    end

    # Show the Wallet Account associated with the Transaction.
    #
    # @see https://reference.promisepay.com/#show-transaction-wallet-account
    #
    # @return [Promisepay::WalletAccount]
    def wallet_account
      response = JSON.parse(@client.get("transactions/#{send(:id)}/wallet_accounts").body)
      response.key?('wallet_accounts') ? Promisepay::WalletAccount.new(@client, response['wallet_accounts']) : nil
    end
  end
end
