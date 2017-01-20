require 'spec_helper'

describe Promisepay::BankAccount do
  let(:client) { Promisepay::Client.new }
  let(:account) do
    VCR.use_cassette('bank_accounts_single') do
      client.bank_accounts.find('8d34d271-80bb-44c3-8733-9ab2665d7bd6')
    end
  end

  let(:account2) do
    VCR.use_cassette('bank_accounts_single_2') do
      client.bank_accounts.find('a4355e4c-25e4-49e3-88bf-63de71bbbea9')
    end
  end

  describe 'user', vcr: { cassette_name: 'bank_accounts_user' } do
    it 'gives back the account owner' do
      expect(account.user).to be_a(Promisepay::User)
    end
  end

  describe 'deactivate' do
    it 'with mobile-pin', vcr: { cassette_name: 'bank_accounts_deactivated' } do
      expect(account.active).to be(true)
      account.deactivate('123')
      expect(account.active).to be(false)
    end
    it 'without mobile-pin', vcr: { cassette_name: 'bank_accounts_deactivated_no_pin'} do
      expect(account2.active).to be(true)
      account2.deactivate()
      expect(account2.active).to be(false)
    end
  end
end
