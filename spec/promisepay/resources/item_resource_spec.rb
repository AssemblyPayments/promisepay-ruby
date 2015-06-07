require 'spec_helper'

describe Promisepay::ItemResource do
  let(:client) { Promisepay::Client.new }
  let(:users) { VCR.use_cassette('users_multiple') { client.users.find_all } }

  describe 'find_all' do
    context 'when no items are available', vcr: { cassette_name: 'items_empty' } do
      it 'gives back an empty array' do
        items = client.items.find_all
        expect(items).to be_empty
      end
    end

    context 'when multiple items are available', vcr: { cassette_name: 'items_multiple' } do
      it 'gives back an array of items' do
        items = client.items.find_all
        expect(items).to_not be_empty
        expect(items.first).to be_kind_of(Promisepay::Item)
      end
    end
  end

  describe 'find' do
    let(:single_item) { VCR.use_cassette('items_multiple') { client.items.find_all.first } }

    context 'an existing item', vcr: { cassette_name: 'items_single' } do
      it 'gives back a single item' do
        item = client.items.find(single_item.id)
        expect(item).to be_a(Promisepay::Item)
      end
    end

    context 'an unknown item', vcr: { cassette_name: 'items_unknown' } do
      it 'returns nil' do
        item = client.items.find('unkown_id')
        expect(item).to be_nil
      end
    end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'items_created' } do
      let(:valid_attributes) do
        {
          id: '99',
          name: 'itemName',
          amount: 500,
          payment_type: 1,  # Escrow
          seller_id: users.first.id,
          buyer_id: users.last.id
        }
      end

      it 'gives back an item' do
        item = client.items.create(valid_attributes)
        expect(item).to be_a(Promisepay::Item)
        expect(item.id).to eql('99')
        expect(item.name).to eql('itemName')
        expect(item.amount).to eql(500)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { {} }

      it 'has to be implemented'
    end
  end
end
