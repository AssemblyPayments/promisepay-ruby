require 'spec_helper'

describe Promisepay::User do
  let(:client) { Promisepay::Client.new }
  let(:user) { VCR.use_cassette('users_multiple') { client.users.find_all.first } }

  describe 'items' do
    context 'when no items are available', vcr: { cassette_name: 'users_items_empty' } do
      it 'gives back an array of items' do
        expect(user.items).to be_empty
      end
    end

    context 'when multiple items are available', vcr: { cassette_name: 'users_items' } do
      it 'gives back an array of items' do
        items = user.items
        expect(items).to_not be_empty
        expect(items.first).to be_a(Promisepay::Item)
      end
    end
  end
end
