module Promisepay
  # Manage Companies
  class Company < BaseModel

  	# Get the user the company belongs to.
    #
    # @see
    #
    # @return [Promisepay::User]
    def user
      response = JSON.parse(@client.get("companies/#{send(:id)}/users").body)
      Promisepay::User.new(@client, response['users'])
    end

    # Gets company address.
    #
    # @see https://reference.promisepay.com/#addresses
    #
    # @return [Hash]
    def address
      return nil unless @attributes.key?('related')
      response = JSON.parse(@client.get("addresses/#{send(:related)['addresses']}").body)
      response['addresses']
    end
  end
end
