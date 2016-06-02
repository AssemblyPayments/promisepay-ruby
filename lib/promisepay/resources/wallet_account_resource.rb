module Promisepay
  # Resource for the Wallet Accounts API
  class WalletAccountResource < BaseResource
    def model
      Promisepay::WalletAccount
    end

    # Get a single wallet account
    #
    # @see https://reference.promisepay.com/#show-wallet-account
    #
    # @param id [String] account ID.
    #
    # @return [Promisepay::WalletAccount]
    def find(id)
      response = JSON.parse(@client.get("wallet_accounts/#{id}").body)
      Promisepay::WalletAccount.new(@client, response['wallet_accounts'])
    end
  end
end
