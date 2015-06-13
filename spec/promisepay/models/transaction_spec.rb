require 'spec_helper'

describe Promisepay::User do
  let(:client) { Promisepay::Client.new }
  let(:transaction) { VCR.use_cassette('transactions_multiple') { client.transactions.find_all.first } }

  describe 'user' do
    context 'when no user is available', vcr: { cassette_name: 'transactions_user_empty' } do
      it 'returns nil'
    end

    context 'when a user is available', vcr: { cassette_name: 'transactions_user' } do
      it 'gives back a user' do
        expect(transaction.user).to be_a(Promisepay::User)
      end
    end
  end

  describe 'fee' do
    context 'when no fee is available', vcr: { cassette_name: 'transactions_fee_empty' } do
      it 'returns nil'
    end

    context 'when a fee is available', vcr: { cassette_name: 'transactions_fee' } do
      it 'gives back a fee'
      # it 'gives back a fee' do
      #   expect(transaction.fee).to be_a(Promisepay::Fee)
      # end
    end
  end
end
