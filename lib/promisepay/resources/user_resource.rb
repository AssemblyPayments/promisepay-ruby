module Promisepay
  # Resource for the Users API
  class UserResource < BaseResource
    # List all users for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/users
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 users. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::User>] List all users for a marketplace.
    def find_all(options = {})
      response = JSON.parse(@client.get('users', options).body)
      users = response.key?('users') ? response['users'] : []
      users.map { |attributes| Promisepay::User.new(@client, attributes) }
    end

    # Get a single user
    #
    # @see http://docs.promisepay.com/v2.2/docs/usersid
    #
    # @param id [String] Marketplace user ID.
    #
    # @return [Promisepay::User]
    def find(id)
      response = JSON.parse(@client.get("users/#{id}").body)
      attributes = response['users']
      Promisepay::User.new(@client, attributes)
    end

    # Create a new user for a marketplace
    #
    # @see http://docs.promisepay.com/v2.2/docs/users-1
    #
    # @param attributes [Hash] User's attributes.
    #
    # @return [Promisepay::User]
    def create(attributes)
      response = JSON.parse(@client.post('users', options).body)
      attributes = response['users']
      Promisepay::User.new(@client, attributes)
    end
  end
end
