module Promisepay
  # Resource for the Users API
  class UserResource < BaseResource
    def model
      Promisepay::User
    end

    # List all users for a marketplace
    #
    # @see https://reference.promisepay.com/#list-users
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
    # @see https://reference.promisepay.com/#show-user
    #
    # @param id [String] Marketplace user ID.
    #
    # @return [Promisepay::User]
    def find(id)
      response = JSON.parse(@client.get("users/#{id}").body)
      Promisepay::User.new(@client, response['users'])
    end

    # Create a new user for a marketplace
    #
    # @see https://reference.promisepay.com/#create-user
    #
    # @param attributes [Hash] User's attributes.
    #
    # @return [Promisepay::User]
    def create(attributes)
      response = JSON.parse(@client.post('users', attributes).body)
      Promisepay::User.new(@client, response['users'])
    end

    # Update a user for a marketplace
    #
    # @see https://reference.promisepay.com/#update-user
    #
    # @param attributes [Hash] User's attributes.
    #
    # @return [Promisepay::User]
    def update(attributes)
      response = JSON.parse(@client.patch('users', attributes).body)
      Promisepay::User.new(@client, response['users'])
    end
  end
end
