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
  end
end
