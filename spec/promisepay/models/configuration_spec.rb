# require 'spec_helper'

# describe Promisepay::Configuration do
#   let(:configuration) { PromisepayFactory.create_configuration }
#   let(:client) { Promisepay::Client.new }

#   describe 'update' do
#     context 'with valid attributes', vcr: { cassette_name: 'configurations_updated' } do
#       let(:valid_attributes) { { enabled: true } }
#       it 'correctly updates the configuration' do
#         expect(configuration.enabled).to be(false)
#         expect(configuration.update(valid_attributes).enabled).to be(true)
#       end
#     end

#     context 'with invalid attributes', vcr: { cassette_name: 'configurations_updated_error' } do
#       let(:invalid_attributes) { { name: 'not a valid name' } }

#       it 'raises an error' do
#         expect { configuration.update(invalid_attributes) }.to raise_error(Promisepay::UnprocessableEntity)
#       end
#     end
#   end

#   describe 'delete' do
#     let!(:configuration) { PromisepayFactory.create_configuration }
#     it 'deletes the direct debit authority', vcr: { cassette_name: 'configurations_delete', allow_playback_repeats: false } do
#       expect { client.configurations.find(configuration.id) }.not_to raise_error
#       expect(configuration.delete).to be(true)
#       expect { client.configurations.find(configuration.id) }.to raise_error(Promisepay::UnprocessableEntity)
#     end
#   end
# end
