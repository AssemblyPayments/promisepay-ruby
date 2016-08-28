module Promisepay
  # Resource for the Items API
  class BatchTransactionResource < BaseResource
    def model
      Promisepay::BatchTransaction
    end

    # List all batch transactions
    #
    # @see https://reference.promisepay.com/#list-batch-transactions
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 items. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    # @option options [Integer] :account_id Bank, Card, PayPal or Wallet Account ID.
    # @option options [Integer] :batch_id Batch ID. This appears on a bank reference.
    # @option options [Integer] :item_id Item ID.
    # @option options [String] :transaction_type The type of transaction.
    #   Available values: payment, refund, disbursement, fee, deposit, withdrawal.
    # @option options [String] :transaction_type_method The method the transaction was carried out with.
    #   Available values: bundle_direct_debit, direct_debit, credit_card, wire_transfer, direct_credit, paypal_payout.
    # @option options [debit, credit] :direction Direction of the transaction.
    #   Available values: debit, credit.
    #
    # @return [Array<Promisepay::BatchTransaction>] List all batch transactions.
    def find_all(options = {})
      response = JSON.parse(@client.get('batch_transactions', options).body)
      batch_transactions = response.key?('batch_transactions') ? response['batch_transactions'] : []
      batch_transactions.map { |attributes| Promisepay::BatchTransaction.new(@client, attributes) }
    end

    # Get a single batch transaction
    #
    # @see https://reference.promisepay.com/#show-batch-transaction
    #
    # @param id [String] Transaction ID.
    #
    # @return [Promisepay::BatchTransaction]
    def find(id)
      response = JSON.parse(@client.get("batch_transactions/#{id}").body)
      Promisepay::BatchTransaction.new(@client, response['batch_transactions'])
    end
  end
end
