module Promisepay
  # Resource for the Direct Debit Authorities API
  class DirectDebitAuthorityResource < BaseResource
    def model
      Promisepay::DirectDebitAuthority
    end

    # List existing direct debit authorities for a given bank account
    #
    # @see https://reference.promisepay.com/#list-direct-debit-authorities
    #
    # @param account_id [String] account id to retrieve direct debit authorities from.
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 users. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::DirectDebitAuthority>] List of direct debit authorities.
    def find_all(account_id, options = {})
      response = JSON.parse(@client.get('direct_debit_authorities', { account_id: account_id }.merge(options)).body)
      direct_debit_authorities = response.key?('direct_debit_authorities') ? response['direct_debit_authorities'] : []
      direct_debit_authorities.map { |attributes| Promisepay::DirectDebitAuthority.new(@client, attributes) }
    end

    # Show details of a specific Direct Debit Authority
    #
    # @see https://reference.promisepay.com/#show-direct-debit-authority
    #
    # @param id [String] direct debit authority ID.
    #
    # @return [Promisepay::DirectDebitAuthority]
    def find(id)
      response = JSON.parse(@client.get("direct_debit_authorities/#{id}").body)
      Promisepay::DirectDebitAuthority.new(@client, response['direct_debit_authorities'])
    end

    # Create a Direct Debit Authority associated with a Bank Account.
    #
    # @see https://reference.promisepay.com/#create-direct-debit-authority
    #
    # @param attributes [Hash] Direct Debit Authority's attributes.
    #
    # @return [Promisepay::DirectDebitAuthority]
    def create(attributes)
      response = JSON.parse(@client.post('direct_debit_authorities', attributes).body)
      Promisepay::DirectDebitAuthority.new(@client, response['direct_debit_authorities'])
    end
  end
end
