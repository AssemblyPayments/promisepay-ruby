require 'spec_helper'

describe Promisepay::TokenResource do
  let(:client) { Promisepay::Client.new }

  describe 'create' do
    context 'for a marketplace that passes the Item and User IDs.', vcr: { cassette_name: 'token_session_created_with_id' } do
      let(:seller) { 'ZTFUYHCY' }
      let(:buyer) { 'WRQBFLOB' }
      let(:item) { 'QCRCDGLA' }
      let(:valid_attributes) do
        {
          current_user_id: seller,
          item_name: 'Sample Item',
          amount: '250000',
          seller_lastname: 'Seller',
          seller_firstname: 'Sally',
          buyer_lastname: 'Buyer',
          buyer_firstname: 'Bobby',
          seller_email: "test+#{seller}@promisepay.com",
          buyer_email: "test+#{buyer}@promisepay.com",
          external_item_id: item,
          external_seller_id: seller,
          external_buyer_id: buyer,
          payment_type_id: 2,
          buyer_country: 'AUS',
          seller_country: 'AUS',
          fee_ids: ['d0cbc1fa-bbd6-4923-8405-b4f0183428ed', '456f9f7b-222e-47fc-a370-7abf45e748f4']
        }
      end

      it 'returns a token' do
        response = client.tokens.create(:session, valid_attributes)
        expect(response).to be_a(String)
        expect(response).not_to be_empty
      end
    end

    # context 'for a marketplace configured to have the Item and User IDs generated automatically for them.', vcr: { cassette_name: 'token_session_created_without_id' } do
    #   let(:valid_attributes) do
    #     {
    #       current_user: 'seller',
    #       item_name: 'Sample Item',
    #       amount: '250000',
    #       seller_lastname: 'Seller',
    #       seller_firstname: 'Sally',
    #       buyer_lastname: 'Buyer',
    #       buyer_firstname: 'Bobby',
    #       seller_email: 'sally.seller@promisepay.com',
    #       buyer_email: 'bobby.buyer@promisepay.com',
    #       payment_type_id: 2,
    #       buyer_country: 'AUS',
    #       seller_country: 'AUS',
    #       fee_ids: []
    #     }
    #   end
    #   it 'returns a token' do
    #     response = client.tokens.create(:session, valid_attributes)
    #     expect(response).to be_a(String)
    #     expect(response).not_to be_empty
    #   end
    # end
  end
end
