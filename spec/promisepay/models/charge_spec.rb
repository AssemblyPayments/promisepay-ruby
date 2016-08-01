require 'spec_helper'

describe Promisepay::Charge do
  let(:user) { PromisepayFactory.create_user }
  let(:account) { PromisepayFactory.create_card_account({}, user) }
  let(:charge) { PromisepayFactory.create_charge({}, account, user) }

  describe 'buyer' do
    it 'returns the buyer associated with the charge', vcr: { cassette_name: 'charges_buyer' } do
      buyer = charge.buyer
      expect(buyer).to be_a(Promisepay::User)
      expect(buyer.id).to eq(user.id)
    end
  end

  describe 'status' do
    it 'return an Hash with expected keys', vcr: { cassette_name: 'charges_status' } do
      status = charge.status
      expect(status).to be_a(Hash)
      expect(status).to have_key('status')
      expect(status).to have_key('state')
    end
  end
end
