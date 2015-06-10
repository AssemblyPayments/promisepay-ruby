require 'spec_helper'

describe Promisepay::User do
  let(:client) { Promisepay::Client.new }
  let(:user) { VCR.use_cassette('users_multiple') { client.users.find_all.first } }

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

  describe 'bank_account' do
    context 'no acccount available', vcr: { cassette_name: 'users_bank_account_empty' } do
      it 'returns nil' do
        expect(user.bank_account).to be_nil
      end
    end

    # context 'account available', vcr: { cassette_name: 'users_bank_account' } do
    #   it 'gives back a Bank account' do
    #     expect(user.bank_account).to be_a(Promisepay::BankAccount)
    #   end
    # end
  end

  describe 'card_account' do
    context 'no acccount available', vcr: { cassette_name: 'users_card_account_empty' } do
      it 'returns nil' do
        expect(user.card_account).to be_nil
      end
    end

    # context 'account available', vcr: { cassette_name: 'users_card_account' } do
    #   it 'gives back a Card account' do
    #     expect(user.card_account).to be_a(Promisepay::CardAccount)
    #   end
    # end
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
end
