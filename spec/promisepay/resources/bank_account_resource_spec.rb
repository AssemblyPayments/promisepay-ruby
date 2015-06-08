require 'spec_helper'

describe Promisepay::BankAccountResource do
  let(:client) { Promisepay::Client.new }

  describe 'find' do
    context 'an existing bank_account', vcr: { cassette_name: 'bank_accounts_single' } do
      it 'gives back a single bank_account' do
        bank_account = client.bank_accounts.find('8d34d271-80bb-44c3-8733-9ab2665d7bd6')
        expect(bank_account).to be_a(Promisepay::BankAccount)
      end
    end

    context 'an unknown bank_account', vcr: { cassette_name: 'bank_accounts_unknown' } do
      it 'raises an error' do
        unknown_id = '0d34d271-80bb-44c3-8733-9ab2665d7bd0'
        expect { client.bank_accounts.find(unknown_id) }.to raise_error(Promisepay::Unauthorized)
      end
    end

    context 'with an invalid id', vcr: { cassette_name: 'bank_accounts_invalid' } do
      it 'raises an error' do
        expect {
          client.bank_accounts.find('not_an_id')
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'bank_accounts_created' } do
      let(:user) { VCR.use_cassette('users_multiple') { client.users.find_all.first } }

      let(:valid_attributes) do
        {
          user_id: user.id,
          bank_name: 'myBank',
          account_name: 'myAccount',
          routing_number: '0000000000000',
          account_number: '0000000000000',
          account_type: 'savings',
          holder_type: 'personal',
          country: 'AUS',
          mobile_pin: '123'
        }
      end

      it 'gives back a bank_account' do
        bank_account = client.bank_accounts.create(valid_attributes)
        expect(bank_account).to be_a(Promisepay::BankAccount)
        expect(bank_account.bank['bank_name']).to eql('myBank')
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'bank_accounts_created_error' } do
      let(:invalid_attributes) { { user_id: nil } }

      it 'raises an error' do
        expect {
          client.bank_accounts.create(invalid_attributes)
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'bank_account methods' do
    it 'can be accessed' do
      expect(client.bank_accounts.respond_to?(:user)).to be(true)
    end
  end
end
