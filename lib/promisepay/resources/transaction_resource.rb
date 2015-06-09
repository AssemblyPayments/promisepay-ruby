module Promisepay
  # Resource for the Transactions API
  class TransactionResource < BaseResource
    def model
      Promisepay::Transaction
    end

    # List all transactions for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/transactions
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 transactions. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::Transaction>] List all transactions for a marketplace.
    def find_all(options = {})
      response = JSON.parse(@client.get('transactions', options).body)
      transactions = response.key?('transactions') ? response['transactions'] : []
      transactions.map { |attributes| Promisepay::Transaction.new(@client, attributes) }
    end

    # Get a single transaction for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/transactionsid
    #
    # @param id [String] transaction ID.
    #
    # @return [Promisepay::Transaction]
    def find(id)
      response = JSON.parse(@client.get("transactions/#{id}").body)
      Promisepay::Transaction.new(@client, response['transactions'])
    end
  end
end
