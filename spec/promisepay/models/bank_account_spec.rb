require 'spec_helper'

describe Promisepay::BankAccount do
  let(:client) { Promisepay::Client.new }
  let(:account) do
    VCR.use_cassette('bank_accounts_single') do
      client.bank_accounts.find('8d34d271-80bb-44c3-8733-9ab2665d7bd6')
    end
  end

  describe 'user', vcr: { cassette_name: 'bank_accounts_user' } do
    it 'gives back the account owner' do
      expect(account.user).to be_a(Promisepay::User)
    end
  end

  describe 'deactivate' do
    it 'deactivates the account', vcr: { cassette_name: 'bank_accounts_deactivated' } do
      expect(account.active).to be(true)
      account.deactivate('123')
      expect(account.active).to be(false)
    end
  end

  # describe 'penny verification' do
  #   let(:bank_account) { PromisepayFactory.create_bank_account }

  #   describe 'send_penny' do
  #     it 'returns a bank account', vcr: { cassette_name: 'bank_accounts_send_penny_1' } do
  #       expect(bank_account.send_penny).to be_a(Promisepay::BankAccount)
  #     end

  #     it 'flags the bank acount as verifying', vcr: { cassette_name: 'bank_accounts_send_penny_2' } do
  #       expect(bank_account.send_penny.verification_status).to eql 'verifying'
  #     end
  #   end

  #   describe 'verify_penny' do
  #     before { bank_account.send_penny }
  #     subject { bank_account.verify_penny(amount_1, amount_2) }
  #     context 'when amounts are correct', vcr: { cassette_name: 'bank_accounts_verify_penny_right' } do
  #       let(:amount_1) { 6 }
  #       let(:amount_2) { 27 }
  #       it { is_expected.to be(true) }
  #     end

  #     context 'when amounts are incorrect', vcr: { cassette_name: 'bank_accounts_verify_penny_wrong' } do
  #       let(:amount_1) { 6 }
  #       let(:amount_2) { 27 }
  #       it { is_expected.to be(false) }
  #     end
  #   end
  # end
end
