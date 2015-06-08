require 'spec_helper'

describe Promisepay::BankAccount do
  let(:client) { Promisepay::Client.new }
  let(:account) do
    VCR.use_cassette('bank_accounts_single') do
      client.bank_accounts.find('8d34d271-80bb-44c3-8733-9ab2665d7bd6')
    end
  end

  describe 'user', vcr: { cassette_name: 'bank_accounts_user' } do
    it 'gives back the account owner' do
      expect(account.user).to be_a(Promisepay::User)
    end
  end

  describe 'deactivate!' do
    it 'deactivates the account', vcr: { cassette_name: 'bank_accounts_deactivated' } do
      expect(account.active).to be(true)
      account.deactivate!('123')
      expect(account.active).to be(false)
    end
  end
end
