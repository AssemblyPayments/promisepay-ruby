require 'spec_helper'

describe Promisepay::TransactionResource do
  let(:client) { Promisepay::Client.new }
  let(:users) { VCR.use_cassette('users_multiple') { client.users.find_all } }

  describe 'find_all' do
    context 'when no transactions are available', vcr: { cassette_name: 'transactions_empty' } do
      it 'gives back an empty array' do
        transactions = client.transactions.find_all
        expect(transactions).to be_empty
      end
    end

    context 'when multiple transactions are available', vcr: { cassette_name: 'transactions_multiple' } do
      it 'gives back an array of transactions' do
        transactions = client.transactions.find_all
        expect(transactions).to_not be_empty
        expect(transactions.first).to be_kind_of(Promisepay::Transaction)
      end
    end
  end

  describe 'find' do
    let(:single_transaction) do
      VCR.use_cassette('transactions_multiple') { client.transactions.find_all.first }
    end

    context 'an existing transaction', vcr: { cassette_name: 'transactions_single' } do
      it 'gives back a single transaction' do
        transaction = client.transactions.find(single_transaction.id)
        expect(transaction).to be_a(Promisepay::Transaction)
      end
    end

    context 'an unknown transaction', vcr: { cassette_name: 'transactions_unknown' } do
      it 'raises an error' do
        unkown_id = 'e842e9f5-4603-4969-aa42-2e60abe2d630'
        expect { client.transactions.find(unkown_id) }.to raise_error(Promisepay::Unauthorized)
      end
    end
  end

  describe 'transaction methods' do
    it 'can be accessed' do
      expect(client.transactions.respond_to?(:user)).to be(true)
    end
  end
end
