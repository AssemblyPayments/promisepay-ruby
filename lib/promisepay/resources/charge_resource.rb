module Promisepay
  # Resource for the Charges API
  class ChargeResource < BaseResource
    def model
      Promisepay::Charge
    end

    # List all charges
    #
    # @see https://reference.promisepay.com/#list-charges
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 charges. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::Charge>] List all charges.
    def find_all(options = {})
      response = JSON.parse(@client.get('charges', options).body)
      charges = response.key?('charges') ? response['charges'] : []
      charges.map { |attributes| Promisepay::Charge.new(@client, attributes) }
    end

    # Get a single charge
    #
    # @see https://reference.promisepay.com/#show-charge
    #
    # @param id [String] Charge ID.
    #
    # @return [Promisepay::Charge]
    def find(id)
      response = JSON.parse(@client.get("charges/#{id}").body)
      Promisepay::Charge.new(@client, response['charges'])
    end

    # Create a new charge for a marketplace
    #
    # @see https://reference.promisepay.com/#create-charge
    #
    # @param attributes [Hash] Charge's attributes.
    #
    # @return [Promisepay::Charge]
    def create(attributes)
      response = JSON.parse(@client.post('charges', attributes).body)
      Promisepay::Charge.new(@client, response['charges'])
    end
  end
end
