require 'spec_helper'

describe Promisepay::PaypalAccount do
  let(:client) { Promisepay::Client.new }
  let(:account) do
    VCR.use_cassette('paypal_accounts_single') do
      client.paypal_accounts.find('fdc5e5e4-b5d2-456b-8d42-ff349ccf8346')
    end
  end

  describe 'user', vcr: { cassette_name: 'paypal_accounts_user' } do
    it 'gives back the account owner' do
      expect(account.user).to be_a(Promisepay::User)
    end
  end

  describe 'deactivate!' do
    it 'deactivates the account', vcr: { cassette_name: 'paypal_accounts_deactivated' } do
      expect(account.active).to be(true)
      account.deactivate!
      expect(account.active).to be(false)
    end
  end
end
