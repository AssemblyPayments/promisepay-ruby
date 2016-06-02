module Promisepay
  # Manage Wallet Accounts
  class WalletAccount < BaseModel
    # Show the User the Wallet Account is associated with
    #
    # @return [Promisepay::User]
    def user
      response = JSON.parse(@client.get("wallet_accounts/#{send(:id)}/users").body)
      response.key?('users') ? Promisepay::User.new(@client, response['users']) : nil
    end
  end
end
