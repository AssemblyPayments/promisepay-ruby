require 'spec_helper'

describe Promisepay::DirectDebitAuthorityResource do
  let(:client) { Promisepay::Client.new }

  describe 'find_all' do
    let(:account) { PromisepayFactory.create_bank_account }

    context 'when no direct debit authorities are available', vcr: { cassette_name: 'direct_debit_authorities_empty' } do
      it 'gives back an empty array' do
        direct_debit_authorities = client.direct_debit_authorities.find_all(account.id)
        expect(direct_debit_authorities).to be_empty
      end
    end

    context 'when direct debit authorities are available', vcr: { cassette_name: 'direct_debit_authorities_multiple' } do
      before { PromisepayFactory.create_direct_debit_authority({}, account) }
      it 'gives back an array of direct debit authorities' do
        direct_debit_authorities = client.direct_debit_authorities.find_all(account.id)
        expect(direct_debit_authorities).to_not be_empty
        expect(direct_debit_authorities.first).to be_a(Promisepay::DirectDebitAuthority)
      end
    end
  end

  describe 'find' do
    context 'an existing direct debit authority', vcr: { cassette_name: 'direct_debit_authority_single' } do
      let(:dda) { PromisepayFactory.create_direct_debit_authority }
      it 'gives back a single wallet_account' do
        direct_debit_authority = client.direct_debit_authorities.find(dda.id)
        expect(direct_debit_authority).to be_a(Promisepay::DirectDebitAuthority)
      end
    end

    context 'with an unknown id', vcr: { cassette_name: 'direct_debit_authority_unknown' } do
      it 'raises an error' do
        expect {
          client.direct_debit_authorities.find('not_an_id')
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'direct_debit_authority_created' } do
      let(:account) { PromisepayFactory.create_bank_account }
      let(:valid_attributes) { { account_id: account.id, amount: '100000' } }

      it 'gives back a direct debit authority' do
        dda = client.direct_debit_authorities.create(valid_attributes)
        expect(dda).to be_a(Promisepay::DirectDebitAuthority)
        expect(dda.amount).to eql(100000)
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'direct_debit_authority_created_error' } do
      let(:invalid_attributes) { { account_id: 'not-an-id', amount: '100000' } }

      it 'raises an error' do
        expect {
          client.direct_debit_authorities.create(invalid_attributes)
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'direct_debit_authority methods' do
    it 'can be accessed' do
      expect(client.direct_debit_authorities).to respond_to(:delete)
    end
  end
end
