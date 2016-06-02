require 'spec_helper'

describe Promisepay::WalletAccountResource do
  let(:client) { Promisepay::Client.new }

  describe 'find' do
    context 'an existing wallet_account', vcr: { cassette_name: 'wallet_accounts_single' } do
      let(:user) { PromisepayFactory.create_user }
      it 'gives back a single wallet_account' do
        wallet = user.wallet_account
        wallet_account = client.wallet_accounts.find(wallet.id)
        expect(wallet_account).to be_a(Promisepay::WalletAccount)
      end
    end

    context 'an unknown wallet_account', vcr: { cassette_name: 'wallet_accounts_unknown' } do
      it 'raises an error' do
        unknown_id = '385b50bb-237a-42cb-9382-22953e191ae6'
        expect { client.wallet_accounts.find(unknown_id) }.to raise_error(Promisepay::Unauthorized)
      end
    end

    context 'with an invalid id', vcr: { cassette_name: 'wallet_accounts_invalid' } do
      it 'raises an error' do
        expect {
          client.wallet_accounts.find('not_an_id')
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'wallet_account methods' do
    it 'can be accessed' do
      expect(client.wallet_accounts.respond_to?(:user)).to be(true)
    end
  end
end
