require 'spec_helper'

describe Promisepay::CallbackResource do
  let(:client) { Promisepay::Client.new }

  describe 'find_all' do
    context 'when no callbacks are available', vcr: { cassette_name: 'callbacks_empty' } do
      it 'gives back an empty array' do
        callbacks = client.callbacks.find_all
        expect(callbacks).to be_empty
      end
    end

    context 'when multiple callbacks are available', vcr: { cassette_name: 'callbacks_multiple' } do
      it 'gives back an array of Callback' do
        callbacks = client.callbacks.find_all
        expect(callbacks).to be_a(Array)
        expect(callbacks.first).to be_a(Promisepay::Callback)
      end
    end
  end

  describe 'find' do
    let(:single_callback) { VCR.use_cassette('callbacks_single_find') { client.callbacks.find("d37282d9-d265-4559-96f2-ca7cfc1cf851") } }

    context 'an existing callback' do
      it 'gives back a single callback' do
        expect(single_callback).to be_a(Promisepay::Callback)
      end
    end

    context 'an unknown callback', vcr: { cassette_name: 'callbacks_unknown' } do
      it 'raises an error' do
        pending "Promisepay API raise 500 instead of Promisepay::Unauthorized"
        expect { client.callbacks.find('unkown_id') }.to raise_error(Promisepay::Unauthorized)
      end
    end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'callback_created' } do
      let(:valid_attributes) do
        {
          url: 'https://httpbin.org/post',
          description: 'User Callback',
          object_type: 'users',
          enabled: 'true'
        }
      end

      it 'gives back a callback' do
        callback = client.callbacks.create(valid_attributes)
        expect(callback).to be_a(Promisepay::Callback)
        expect(callback.url).to eql('https://httpbin.org/post')
        expect(callback.description).to eql('User Callback')
        expect(callback.object_type).to eql('users')
        expect(callback.enabled).to be true
        expect(callback.id).not_to be_nil
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'callback_created_error' } do
      let(:invalid_attributes) { { url: 'notAnurl' } }

      it 'raises an error' do
        expect {
          client.callbacks.create(invalid_attributes)
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'update' do
    let!(:callback) { PromisepayFactory.create_callback }
    context 'with valid attributes', vcr: { cassette_name: 'callback_updated' } do
      let(:attributes) { { id: callback.id, enabled: 'false' } }

      it 'updates the callback' do
        callback = client.callbacks.update(attributes)
        expect(callback).to be_a(Promisepay::Callback)
        expect(callback.enabled).to be false
      end
    end
  end
end
