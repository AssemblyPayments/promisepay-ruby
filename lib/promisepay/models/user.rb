module Promisepay
  # Manage Users
  class User < BaseModel
    # Lists items for a user on a marketplace.
    #
    # @see http://docs.promisepay.com/v2.2/docs/usersiditems
    #
    # @return [Array<Promisepay::Item>]
    def items
      response = JSON.parse(@client.get("users/#{send(:id)}/items").body)
      users = response.key?('items') ? response['items'] : []
      users.map { |attributes| Promisepay::Item.new(@client, attributes) }
    end
  end
end
