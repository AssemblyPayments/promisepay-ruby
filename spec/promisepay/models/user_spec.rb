require 'spec_helper'

describe Promisepay::User do
  let(:client) { Promisepay::Client.new }
  let(:user) { VCR.use_cassette('users_single') { client.users.find('1') } }

  describe 'items' do
    context 'when no items are available', vcr: { cassette_name: 'users_items_empty' } do
      it 'gives back an array of items' do
        expect(user.items).to be_empty
      end
    end

    context 'when multiple items are available', vcr: { cassette_name: 'users_items' } do
      it 'gives back an array of items' do
        items = user.items
        expect(items).to_not be_empty
        expect(items.first).to be_a(Promisepay::Item)
      end
    end
  end

  # describe 'company' do
  #   context 'no company available', vcr: { cassette_name: 'users_company_empty' } do
  #     it 'returns nil' do
  #       expect(user.company).to be_nil
  #     end
  #   end
  #
  #   context 'company available', vcr: { cassette_name: 'users_company_available' } do
  #     it 'gives back a company' do
  #       expect(user.company).to be_a(Promisepay::Company)
  #     end
  #   end
  # end

  describe 'bank_account' do
    context 'no acccount available', vcr: { cassette_name: 'users_bank_account_empty' } do
      it 'returns nil' do
        expect(user.bank_account).to be_nil
      end
    end

    context 'account available', vcr: { cassette_name: 'users_bank_account' } do
      it 'gives back a Bank account' do
        expect(user.bank_account).to be_a(Promisepay::BankAccount)
      end
    end
  end

  describe 'card_account' do
    context 'no acccount available', vcr: { cassette_name: 'users_card_account_empty' } do
      it 'returns nil' do
        expect(user.card_account).to be_nil
      end
    end

    context 'account available', vcr: { cassette_name: 'users_card_account' } do
      it 'gives back a Card account' do
        expect(user.card_account).to be_a(Promisepay::CardAccount)
      end
    end
  end

  describe 'paypal_account' do
    context 'no acccount available', vcr: { cassette_name: 'users_paypal_account_empty' } do
      it 'returns nil' do
        expect(user.paypal_account).to be_nil
      end
    end

    context 'account available', vcr: { cassette_name: 'users_paypal_account' } do
      it 'gives back a PayPal account' do
        expect(user.paypal_account).to be_a(Promisepay::PaypalAccount)
      end
    end
  end

  describe 'disbursement_account', vcr: { cassette_name: 'users_disbursement_account' } do
    let(:bank_account) do
      VCR.use_cassette('bank_account_single') do
        client.bank_accounts.find('8d34d271-80bb-44c3-8733-9ab2665d7bd6')
      end
    end

    it 'returns true' do
      expect(user.disbursement_account(bank_account.id)).to be(true)
    end
  end

  describe 'address', vcr: { cassette_name: 'users_address'} do
    let(:user) { PromisepayFactory.create_user }
    it 'returns a Hash' do
      address = user.address
      expect(address).to be_a(Hash)
      expect(address).to have_key('addressline1')
      expect(address).to have_key('country')
    end
  end
end
