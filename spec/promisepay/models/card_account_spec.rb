require 'spec_helper'

describe Promisepay::CardAccount do
  let(:client) { Promisepay::Client.new }
  let(:account) do
    VCR.use_cassette('card_accounts_single') do
      client.card_accounts.find('25d34744-8ef0-46a4-8b18-2a8322933cd1')
    end
  end

  describe 'user', vcr: { cassette_name: 'card_accounts_user' } do
    it 'gives back the account owner' do
      expect(account.user).to be_a(Promisepay::User)
    end
  end

  describe 'deactivate' do
    it 'deactivates the account', vcr: { cassette_name: 'card_accounts_deactivated' } do
      expect(account.active).to be(true)
      account.deactivate
      expect(account.active).to be(false)
    end
  end
end
