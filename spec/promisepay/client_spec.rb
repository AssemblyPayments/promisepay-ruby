require 'spec_helper'

describe Promisepay::Client do
  let(:client) { Promisepay::Client.new }

  describe 'initialize' do
    before { EnvironmentVariables.clean_up && Promisepay.setup }
    after { EnvironmentVariables.restore && Promisepay.setup }

    context 'without parameters' do
      it 'configures client with default values' do
        expect(client.api_domain).to be_a(String)
        expect(client.environment).to be_a(String)
        expect(client.username).to be_nil
        expect(client.token).to be_nil
      end
    end

    context 'with parameters' do
      let(:client_with_params) do
        Promisepay::Client.new(
          api_domain: 'api.domain.com',
          environment: 'production',
          username: 'myUsername',
          token: 'myToken'
        )
      end

      it 'properly configures client' do
        expect(client_with_params.api_domain).to eql('api.domain.com')
        expect(client_with_params.environment).to eql('production')
        expect(client_with_params.username).to eql('myUsername')
        expect(client_with_params.token).to eql('myToken')
      end
    end

    context 'with environment variables' do
      before do
        ENV['PROMISEPAY_ENVIRONMENT'] = 'env_environment'
        ENV['PROMISEPAY_API_DOMAIN'] = 'env_api_domain'
        ENV['PROMISEPAY_USERNAME'] = 'env_username'
        ENV['PROMISEPAY_TOKEN'] = 'env_token'
        Promisepay.setup
      end

      it 'properly configures client' do
        expect(client.environment).to eql('env_environment')
        expect(client.api_domain).to eql('env_api_domain')
        expect(client.username).to eql('env_username')
        expect(client.token).to eql('env_token')
      end
    end
  end

  describe 'connection' do
    it 'returns a Faraday connection' do
      expect(client.connection).to be_a(Faraday::Connection)
    end
  end

  describe 'CRUD requests' do
    it 'are available' do
      expect(client).to respond_to(:get).with(2).arguments
      expect(client).to respond_to(:post).with(2).arguments
      expect(client).to respond_to(:patch).with(2).arguments
      expect(client).to respond_to(:delete).with(2).arguments
    end
  end

  describe 'marketplace' do
    it 'returns a Hash', vcr: { cassette_name: 'marketplace' } do
      marketplace = client.marketplace
      expect(marketplace).to be_a(Hash)
      expect(marketplace).to have_key('id')
      expect(marketplace).to have_key('related')
    end
  end

  describe 'self.resources' do
    it 'contains all available resources' do
      expect(Promisepay::Client.resources).to be_a(Hash)
      expect(Promisepay::Client.resources).to_not be_empty
    end
  end

  describe 'resources' do
    context 'when no request was previously made' do
      it 'is empty' do
        expect(client.resources).to be_empty
      end
    end

    context 'when requests were previously made', vcr: { cassette_name: 'users_multiple' }  do
      before { client.users.find_all }

      it 'is not empty' do
        expect(client.resources).to_not be_empty
      end

      it 'contains previosuly used resources' do
        expect(client.resources).to have_key(:users)
      end
    end
  end
end
