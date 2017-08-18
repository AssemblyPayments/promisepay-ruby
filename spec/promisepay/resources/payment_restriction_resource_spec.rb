require 'spec_helper'

describe Promisepay::PaymentRestrictionResource do
  let(:client) { Promisepay::Client.new }

  describe 'find_all' do
    subject { client.payment_restrictions.find_all }
    context 'when no payment restrictions are available', vcr: { cassette_name: 'payment_restrictions_empty' } do
      it { is_expected.to be_empty }
    end

    # context 'when multiple payment restrictions are available', vcr: { cassette_name: 'payment_restrictions_multiple' } do
    #   before { PromisepayFactory.create_payment_restriction }

    #   it 'gives back an array of payment_restrictions' do
    #     expect(subject).to_not be_empty
    #     expect(subject.first).to be_kind_of(Promisepay::PaymentRestriction)
    #   end
    # end
  end

  describe 'find' do
    # context 'an existing item', vcr: { cassette_name: 'payment_restrictions_single' } do
    #   let(:payment_restriction) { PromisepayFactory.create_payment_restriction }
    #   it 'gives back a single item' do
    #     item = client.payment_restrictions.find(payment_restriction.id)
    #     expect(item).to be_a(Promisepay::Item)
    #   end
    # end

    # context 'an unknown item', vcr: { cassette_name: 'payment_restrictions_unknown' } do
    #   it 'raises an error' do
    #     expect { client.payment_restrictions.find('unkown_id') }.to raise_error(Promisepay::Unauthorized)
    #   end
    # end
  end
end
