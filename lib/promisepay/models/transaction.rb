module Promisepay
  # Manage Transactions
  class Transaction < Account
    # .
    #
    # @see https://test.api.promisepay.com/transactions/:id/users
    #
    # @return [Promisepay::User]
    def user
      response = JSON.parse(@client.get("transactions/#{send(:id)}/users").body)
      response.key?('users') ? Promisepay::User.new(@client, response['users']) : nil
    end

    # Gets a transactions fee details if applicable.
    #
    # @see http://docs.promisepay.com/v2.2/docs/transactionsidfees
    #
    # @return [Promisepay::Fee]
    def fee
      response = JSON.parse(@client.get("transactions/#{send(:id)}/fees").body)
      response.key?('fees') ? Promisepay::Fee.new(@client, response['fees']) : nil
    end
  end
end
