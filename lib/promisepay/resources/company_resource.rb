module Promisepay
  # Resource for the Fees API
  class CompanyResource < BaseResource
    def model
      Promisepay::Company
    end

    # List all companies for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/companies
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 users. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::Company>] List all companies for a marketplace.
    def find_all(options = {})
      response = JSON.parse(@client.get('companies', options).body)
      users = response.key?('companies') ? response['companies'] : []
      users.map { |attributes| Promisepay::Company.new(@client, attributes) }
    end

    # Get a company
    #
    # @see 
    #
    # @param id [String] Company id
    #
    # @return [Promisepay::Company]
    def find(id)
      response = JSON.parse(@client.get("companies/#{id}").body)
      Promisepay::Company.new(@client, response['companies'])
    end

    # Create a company for a user
    #
    # @see 
    #
    # @param attributes [Hash] Company's attributes.
    #
    # @return [Promisepay::Company]
    def create(attributes)
      response = JSON.parse(@client.post('companies', attributes).body)
      Promisepay::Company.new(@client, response['companies'])
    end

    # Update a company for a user
    #
    # @see 
    #
    # @param attributes [Hash] Company's attributes.
    #
    # @return [Promisepay::Company]
    def update(attributes)
      response = JSON.parse(@client.patch('companies', attributes).body)
      Promisepay::Company.new(@client, response['companies'])
    end
  end
end
