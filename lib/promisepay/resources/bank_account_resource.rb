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

    # Validate a US bank routing number before creating an account.
    # This can be used to provide on-demand verification,
    # and further information of the bank information a User is providing.
    #
    # @see https://reference.promisepay.com/#validate-routing-number
    #
    # @param routing_number [String] Bank account Routing Number
    #
    # @return [Hash]
    def validate(routing_number)
      response = @client.get('tools/routing_number', { routing_number: routing_number }, true)
      (response.status == 200) ? JSON.parse(response.body)['routing_number'] : {}
    end
  end
end
