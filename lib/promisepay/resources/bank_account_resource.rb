module Promisepay
  # Resource for the BankAccounts API
  class BankAccountResource < AccountResource
    def model
      Promisepay::BankAccount
    end

    # Get bank account for a user on a marketplace.
    #
    # @see https://reference.promisepay.com/#show-bank-account
    #
    # @param id [String] Bank Account ID.
    #
    # @return [Promisepay::BankAccount]
    def find(id)
      response = JSON.parse(@client.get("bank_accounts/#{id}").body)
      Promisepay::BankAccount.new(@client, response['bank_accounts'])
    end

    # Create a bank account for a user on a marketplace.
    #
    # @see https://reference.promisepay.com/#create-bank-account
    #
    # @param attributes [Hash] Bank Account's attributes.
    #
    # @return [Promisepay::BankAccount]
    def create(attributes)
      response = JSON.parse(@client.post('bank_accounts', attributes).body)
      Promisepay::BankAccount.new(@client, response['bank_accounts'])
    end
  end
end
