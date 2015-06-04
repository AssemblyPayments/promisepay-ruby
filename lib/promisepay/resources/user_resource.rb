module Promisepay
  class Client

    class UserResource

      def initialize(client)
        @client = client
      end

      def find_all(options = {})
        response = JSON.parse(@client.get('users').body)
        users = response.key?('users') ? response['users'] : []
        users.map { |attributes| Promisepay::Client::User.new(@client, attributes) }
      end

      def find(id)
        response = JSON.parse(@client.get("users/#{id}").body)
        attributes = response['users']
        Promisepay::Client::User.new(@client, attributes)
      end
   end
  end
end
