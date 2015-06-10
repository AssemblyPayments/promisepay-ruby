module Promisepay
  # Resource for the Fees API
  class FeeResource < BaseResource
    def model
      Promisepay::Fee
    end

    # List all fees for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/fees-1
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 fees. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::Fee>] List all fees for a marketplace.
    def find_all(options = {})
      response = JSON.parse(@client.get('fees', options).body)
      fees = response.key?('fees') ? response['fees'] : []
      fees.map { |attributes| Promisepay::Fee.new(@client, attributes) }
    end

    # Get a single fee for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/feesid
    #
    # @param id [String] Marketplace Fee ID.
    #
    # @return [Promisepay::Fee]
    def find(id)
      response = JSON.parse(@client.get("fees/#{id}").body)
      Promisepay::Fee.new(@client, response['fees'])
    end

    # Create a fee for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/fee_lists
    #
    # @param attributes [Hash] Item's attributes.
    #
    # @return [Promisepay::Item]
    def create(attributes)
      response = JSON.parse(@client.post('fees', attributes).body)
      Promisepay::Fee.new(@client, response['fees'])
    end
  end
end
