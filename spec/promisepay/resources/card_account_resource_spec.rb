require 'spec_helper'

describe Promisepay::CardAccountResource do
  let(:client) { Promisepay::Client.new }

  describe 'find' do
    context 'an existing card_account', vcr: { cassette_name: 'card_accounts_single' } do
      it 'gives back a single card_account' do
        card_account = client.card_accounts.find('25d34744-8ef0-46a4-8b18-2a8322933cd1')
        expect(card_account).to be_a(Promisepay::CardAccount)
      end
    end

    context 'an unknown card_account', vcr: { cassette_name: 'card_accounts_unknown' } do
      it 'raises an error' do
        unknown_id = '25d34744-8ef0-46a4-8b18-2a8322933cd0'
        expect { client.card_accounts.find(unknown_id) }.to raise_error(Promisepay::Unauthorized)
      end
    end

    context 'with an invalid id', vcr: { cassette_name: 'card_accounts_invalid' } do
      it 'raises an error' do
        expect {
          client.card_accounts.find('not_an_id')
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'card_accounts_created' } do
      let(:user) { VCR.use_cassette('users_multiple') { client.users.find_all.first } }

      let(:valid_attributes) do
        {
          user_id: user.id,
          full_name: 'myCardName',
          number: '4111111111111111',
          expiry_month: Time.now.month,
          expiry_year: Time.now.year + 1,
          cvv: '123'
        }
      end

      it 'gives back a card account' do
        card_account = client.card_accounts.create(valid_attributes)
        expect(card_account).to be_a(Promisepay::CardAccount)
        expect(card_account.id).to be_a(String)
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'card_accounts_created_error' } do
      let(:invalid_attributes) { { user_id: nil } }

      it 'raises an error' do
        expect {
          client.card_accounts.create(invalid_attributes)
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'card_account methods' do
    it 'can be accessed' do
      expect(client.card_accounts.respond_to?(:user)).to be(true)
    end
  end
end
