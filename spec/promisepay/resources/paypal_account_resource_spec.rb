require 'spec_helper'

describe Promisepay::PaypalAccountResource do
  let(:client) { Promisepay::Client.new }

  describe 'find' do
    context 'an existing paypal_account', vcr: { cassette_name: 'paypal_accounts_single' } do
      it 'gives back a single paypal_account' do
        paypal_account = client.paypal_accounts.find('fdc5e5e4-b5d2-456b-8d42-ff349ccf8346')
        expect(paypal_account).to be_a(Promisepay::PaypalAccount)
      end
    end

    context 'an unknown paypal_account', vcr: { cassette_name: 'paypal_accounts_unknown' } do
      it 'raises an error' do
        unknown_id = 'fdc5e5e4-b5d2-456b-8d42-ff349ccf8340'
        expect { client.paypal_accounts.find(unknown_id) }.to raise_error(Promisepay::Unauthorized)
      end
    end

    context 'with an invalid id', vcr: { cassette_name: 'paypal_accounts_invalid' } do
      it 'raises an error' do
        expect {
          client.paypal_accounts.find('not_an_id')
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'paypal_accounts_created' } do
      let(:user) { VCR.use_cassette('users_multiple') { client.users.find_all.first } }

      let(:valid_attributes) do
        {
          user_id: user.id,
          paypal_email: 'aa@mail.com'
        }
      end

      it 'gives back a paypal account' do
        paypal_account = client.paypal_accounts.create(valid_attributes)
        expect(paypal_account).to be_a(Promisepay::PaypalAccount)
        expect(paypal_account.paypal['email']).to eql('aa@mail.com')
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'paypal_accounts_created_error' } do
      let(:invalid_attributes) { { user_id: nil } }

      it 'raises an error' do
        expect {
          client.paypal_accounts.create(invalid_attributes)
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'paypal_account methods' do
    it 'can be accessed' do
      expect(client.paypal_accounts.respond_to?(:user)).to be(true)
    end
  end
end
