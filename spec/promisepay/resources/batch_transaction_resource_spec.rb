require 'spec_helper'

describe Promisepay::BatchTransactionResource do
  let(:client) { Promisepay::Client.new }
  let(:seller) { PromisepayFactory.create_user}
  let(:buyer) { PromisepayFactory.create_user}
  let(:item) { PromisepayFactory.create_item({}, seller, buyer)}
  let(:account) { PromisepayFactory.create_bank_account({}, buyer)}

  describe 'find_all' do
    context 'when no batch transactions are available', vcr: { cassette_name: 'batch_transactions_empty' } do
      it 'gives back an empty array' do
        expect(client.batch_transactions.find_all).to be_empty
      end
    end

    context 'when multiple batch transactions are available', vcr: { cassette_name: 'batch_transactions_multiple' } do
      before do
        client.direct_debit_authorities.create(account_id: account.id, amount: 100_000)
        item.request_payment
        item.make_payment(account_id: account.id)
      end
      it 'gives back an array of batch_transactions' do
        batch_transactions = client.batch_transactions.find_all(item_id: item.id)
        expect(batch_transactions).to_not be_empty
        expect(batch_transactions.first).to be_kind_of(Promisepay::BatchTransaction)
      end
    end
  end

  describe 'find' do
    context 'an existing batch_transaction', vcr: { cassette_name: 'batch_transactions_single' } do
      before do
        client.direct_debit_authorities.create(account_id: account.id, amount: 100_000)
        item.request_payment
        item.make_payment(account_id: account.id)
      end
      it 'gives back a single batch_transaction' do
        batch_transaction = client.batch_transactions.find(item.batch_transactions.first.id)
        expect(batch_transaction).to be_a(Promisepay::BatchTransaction)
      end
    end

    context 'an unknown batch_transaction', vcr: { cassette_name: 'batch_transactions_unknown' } do
      it 'raises an error' do
        expect { client.batch_transactions.find('unkown_id') }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end
end
