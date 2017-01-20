require 'spec_helper'

describe Promisepay::Callback do
  let(:client) { Promisepay::Client.new }
  let!(:callback) { PromisepayFactory.create_callback }

  describe 'update' do
    context 'with valid attributes', vcr: { cassette_name: 'callback_updated' } do
      let(:attributes) { { id: callback.id, enabled: 'false' } }

      it 'updates the callback' do
        expect{callback.update(attributes)}.to change(callback, :enabled).from(true).to(false)
      end
    end
  end
  describe 'delete', vcr: { cassette_name: 'callback_deleted' } do
    it 'updates the callback' do
      expect(callback.delete).to be true
    end
  end
end
