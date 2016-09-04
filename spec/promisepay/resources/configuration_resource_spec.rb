require 'spec_helper'

describe Promisepay::ItemResource do
  let(:client) { Promisepay::Client.new }

  describe 'find_all' do
    subject { client.configurations.find_all }
    context 'when no configurations are available', vcr: { cassette_name: 'configurations_empty' } do
      it { is_expected.to be_empty}
    end

    context 'when multiple configurations are available', vcr: { cassette_name: 'configurations_multiple' } do
      before { PromisepayFactory.create_configuration }
      it 'gives back an array of configurations' do
        expect(subject).to_not be_empty
        expect(subject.first).to be_kind_of(Promisepay::Configuration)
      end
    end
  end

  describe 'find' do
    context 'an existing configuration', vcr: { cassette_name: 'configurations_single' } do
      let!(:configuration) { PromisepayFactory.create_configuration }
      it 'gives back a single configuration' do
        config = client.configurations.find(configuration.id)
        expect(config).to be_a(Promisepay::Configuration)
      end
    end

    context 'an unknown configuration', vcr: { cassette_name: 'configurations_unknown' } do
      it 'raises an error' do
        expect(client.configurations.find('unkown_id')).to be_nil
      end
    end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'configurations_created' } do
      let(:valid_attributes) do
        {
          name: 'partial_refunds',
          enabled: false
        }
      end

      it 'gives back a configuraton' do
        configuration = client.configurations.create(valid_attributes)
        expect(configuration).to be_a(Promisepay::Configuration)
        expect(configuration.id).to be_a(String)
        expect(configuration.name).to eql('partial_refunds')
        expect(configuration.enabled).to be(false)
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'configurations_created_error' } do
      let(:invalid_attributes) { { } }

      it 'raises an error' do
        expect {
          client.configurations.create(invalid_attributes)
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'Configuration methods' do
    it 'can be accessed' do
      expect(client.configurations.respond_to?(:update)).to be(true)
    end
  end
end
