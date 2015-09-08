module Promisepay
  # Manage Companies
  class Company < BaseModel

  	# Get the user the company belongs to.
    #
    # @see 
    #
    # @return [Promisepay::Company]
    def user
      response = JSON.parse(@client.get("companies/#{send(:id)}/users").body)
      Promisepay::Company.new(@client, response['users'])
    end
  end
end
