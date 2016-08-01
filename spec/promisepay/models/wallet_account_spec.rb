require 'spec_helper'

describe Promisepay::WalletAccount do
  let(:user) { PromisepayFactory.create_user }
  let(:wallet_account) { user.wallet_account }

  describe 'user' do
    it 'returns the account owner', vcr: { cassette_name: 'wallet_accounts_user' } do
      expect(wallet_account.user).to be_a(Promisepay::User)
    end
  end

  # describe 'operations' do
  #   let(:bank_account) { PromisepayFactory.create_bank_account({}, user) }
  #   before { user.disbursement_account(bank_account.id) }

  #   describe 'withdraw', vcr: { cassette_name: 'wallet_accounts_withdraw' } do
  #     it 'returns a disbursement' do
  #       disbursement = wallet_account.withdraw(account_id: bank_account.id, amount: 500)
  #       expect(disbursement).to be_a(Hash)
  #       expect(disbursement).to have_key('id')
  #       expect(disbursement).to have_key('amount')
  #       expect(disbursement).to have_key('currency')
  #       expect(disbursement['state']).to eq('pending')
  #       expect(disbursement['to']).to eq('Bank Account')
  #     end
  #   end

  #   describe 'deposit', vcr: { cassette_name: 'wallet_accounts_deposit' } do
  #     it 'returns a disbursement' do
  #       disbursement = wallet_account.deposit(account_id: bank_account.id, amount: 500)
  #       expect(disbursement).to be_a(Hash)
  #       expect(disbursement).to have_key('id')
  #       expect(disbursement).to have_key('amount')
  #       expect(disbursement).to have_key('currency')
  #       expect(disbursement['state']).to eq('pending')
  #     end
  #   end
  # end
end
