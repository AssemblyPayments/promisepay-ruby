require 'spec_helper'

describe Promisepay::FeeResource do
  let(:client) { Promisepay::Client.new }

  describe 'find_all' do
    context 'when no fees are available', vcr: { cassette_name: 'fees_empty' } do
      it 'gives back an empty array' do
        fees = client.fees.find_all
        expect(fees).to be_empty
      end
    end

    context 'when multiple fees are available', vcr: { cassette_name: 'fees_multiple' } do
      it 'gives back an array of fees' do
        fees = client.fees.find_all
        expect(fees).to_not be_empty
        expect(fees.first).to be_kind_of(Promisepay::Fee)
      end
    end
  end

  describe 'find' do
    let(:single_fee) { VCR.use_cassette('fees_multiple') { client.fees.find_all.first } }

    context 'an existing fee', vcr: { cassette_name: 'fees_single' } do
      it 'gives back a single fee' do
        fee = client.fees.find(single_fee.id)
        expect(fee).to be_a(Promisepay::Fee)
      end
    end

    # context 'an unknown fee', vcr: { cassette_name: 'fees_unknown' } do
    #   it 'raises an error' do
    #     expect { client.fees.find('unkown_id') }.to raise_error(Promisepay::Unauthorized)
    #   end
    # end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'fees_created' } do
      let(:valid_attributes) do
        {
          fee_type_id: '1', # Fixed
          name: 'feeName',
          amount: 500,
          to: 'buyer'
        }
      end

      it 'gives back an fee' do
        fee = client.fees.create(valid_attributes)
        expect(fee).to be_a(Promisepay::Fee)
        expect(fee.name).to eql('feeName')
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'fees_created_error' } do
      let(:invalid_attributes) { { fee_type_id: nil } }

      it 'raises an error' do
        expect {
          client.fees.create(invalid_attributes)
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end
end
