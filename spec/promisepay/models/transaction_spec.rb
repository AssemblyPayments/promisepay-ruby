require 'spec_helper'

describe Promisepay::Transaction do
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

  describe 'accounts' do
    let(:buyer) { PromisepayFactory.create_user }
    let(:seller) { PromisepayFactory.create_user }
    let(:item) { PromisepayFactory.create_item({}, seller, buyer) }
    let(:transaction) { item.transactions.last }

    # describe 'bank_account', vcr: { cassette_name: 'transactions_bank_account' } do
    #   let(:account) { PromisepayFactory.create_bank_account({}, buyer) }
    #   before do
    #     buyer.disbursement_account(account_id: account.id)
    #     client.direct_debit_authorities.create(account_id: account.id, amount: '10000')
    #     item.make_payment(account_id: account.id)
    #   end

    #   subject { transaction.bank_account }

    #   it { is_expected.to be_a(Promisepay::BankAccount) }
    # end

    # describe 'card_account', vcr: { cassette_name: 'transactions_card_account' } do
    #   let(:account) { PromisepayFactory.create_card_account({}, buyer) }
    #   before { item.make_payment(account_id: account.id) }
    #   subject { transaction.card_account }

    #   it { is_expected.to be_a(Promisepay::CardAccount) }
    # end

    # describe 'wallet_account', vcr: { cassette_name: 'transactions_wallet_account' } do
    #   let(:account) { buyer.wallet_account }
    #   before { item.make_payment(account_id: account.id) }
    #   subject { transaction.wallet_account }

    #   it { is_expected.to be_a(Promisepay::WalletAccount) }
    # end

    # describe 'paypal_account', vcr: { cassette_name: 'transactions_paypal_account' } do
    #   let(:account) { PromisepayFactory.create_paypal_account({}, buyer) }
    #   before { item.make_payment(account_id: account.id) }
    #   subject { transaction.paypal_account }

    #   it { is_expected.to be_a(Promisepay::PaypalAccount) }
    # end
  end
end
