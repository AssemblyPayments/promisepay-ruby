require 'spec_helper'

describe Promisepay::Item do
  let(:client) { Promisepay::Client.new }
  let(:item) { VCR.use_cassette('items_multiple') { client.items.find_all.first } }

  describe 'update' do
    context 'with valid attributes', vcr: { cassette_name: 'items_updated' } do
      let(:valid_attributes) { { name: 'updatedName' } }
      it 'correctly updates the item' do
        original_name = item.name
        expect(item.update(valid_attributes)).to be(true)
        expect(item.name).to_not eql(original_name)
        expect(item.name).to eql('updatedName')
      end
    end

    context 'with invalid attributes' do
      it 'has to be implemented'
    end
  end

  describe 'status', vcr: { cassette_name: 'items_status' } do
    it 'returns the item status' do
      status = item.status
      expect(status).to be_a(Hash)
      expect(status).to have_key('status')
      expect(status).to have_key('state')
    end
  end

  describe 'buyers', vcr: { cassette_name: 'items_buyers' } do
    it 'returns a user' do
      buyer = item.buyers
      expect(buyer).to be_a(Promisepay::User)
    end
  end

  describe 'sellers', vcr: { cassette_name: 'items_sellers' } do
    it 'returns a user' do
      seller = item.sellers
      expect(seller).to be_a(Promisepay::User)
    end
  end

  describe 'wire_details', vcr: { cassette_name: 'items_wire_details' } do
    it 'returns a Hash' do
      details = item.wire_details
      expect(details).to be_a(Hash)
      expect(details).to have_key('reference')
    end
  end

  describe 'bpay_details', vcr: { cassette_name: 'items_bpay_details' } do
    it 'returns a Hash' do
      details = item.bpay_details
      expect(details).to be_a(Hash)
      expect(details).to have_key('reference')
    end
  end
end
