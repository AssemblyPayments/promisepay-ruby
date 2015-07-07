require 'spec_helper'

describe Promisepay::TokenResource do
  let(:client) { Promisepay::Client.new }

  describe 'create' do
    context 'with valid attributes', vcr: {cassette_name: 'token_session_created'} do
      let(:seller) { (0...8).map { (65 + rand(26)).chr }.join }
      let(:buyer) { (0...8).map { (65 + rand(26)).chr }.join }
      let(:item) { (0...8).map { (65 + rand(26)).chr }.join }
      let(:valid_attributes) do
        {
                current_user_id: seller,
                item_name: "Sample Item",
                amount: "250000",
                seller_lastname: "Seller",
                seller_firstname: "Sally",
                buyer_lastname: "Buyer",
                buyer_firstname: "Bobby",
                seller_email: "test+#{seller}@promisepay.com",
                buyer_email: "test+#{buyer}@promisepay.com",
                external_item_id: item,
                external_seller_id: seller,
                external_buyer_id: buyer,
                payment_type_id: 1,
                buyer_country: "AUS",
                seller_country: "AUS",
                fee_ids: ["d0cbc1fa-bbd6-4923-8405-b4f0183428ed",
                          "456f9f7b-222e-47fc-a370-7abf45e748f4"]
        }
      end

      it 'create new buyer, seller and item then returns token' do
        response = client.tokens.create(:session, valid_attributes)
        response
      end
    end

    # context 'with invalid attributes', vcr: { cassette_name: 'items_created_error' } do
    #   let(:invalid_attributes) { { id: '1' } }
    #
    #   it 'raises an error' do
    #     expect {
    #       client.items.create(invalid_attributes)
    #     }.to raise_error(Promisepay::UnprocessableEntity)
    #   end
    # end
  end
end
