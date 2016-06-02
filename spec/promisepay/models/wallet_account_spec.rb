require 'spec_helper'

describe Promisepay::WalletAccount do
  let(:wallet_account) { PromisepayFactory.create_user.wallet_account }

  describe 'user' do
    it 'returns the account owner', vcr: { cassette_name: 'wallet_accounts_user' } do
      expect(wallet_account.user).to be_a(Promisepay::User)
    end
  end
end
