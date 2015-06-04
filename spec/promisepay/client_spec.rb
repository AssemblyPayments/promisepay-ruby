require 'spec_helper'

describe Promisepay::Client do
  let(:client) { Promisepay::Client.new }

  describe 'initialize' do
    context 'without parameters' do
      it 'configures client with default values' do
        expect(client.api_domain).to be_a(String)
        expect(client.environment).to be_a(String)
        expect(client.username).to be_nil
        expect(client.token).to be_nil
      end
    end

    context 'with parameters' do
      let(:client) do
        Promisepay::Client.new(
          api_domain: 'api.domain.com',
          environment: 'production',
          username: 'myUsername',
          token: 'myToken'
        )
      end
      it 'properly configure client' do
        expect(client.api_domain).to eql('api.domain.com')
        expect(client.environment).to eql('production')
        expect(client.username).to eql('myUsername')
        expect(client.token).to eql('myToken')
      end
    end

    context 'having environment parameters previously set' do
      before do
        @cached_environment = ENV['PROMISEPAY_ENVIRONMENT']
        @cached_api_domain = ENV['PROMISEPAY_API_DOMAIN']
        @cached_useranme = ENV['PROMISEPAY_USERNAME']
        @cached_token = ENV['PROMISEPAY_TOKEN']
        ENV['PROMISEPAY_ENVIRONMENT'] = 'env_environment'
        ENV['PROMISEPAY_API_DOMAIN'] = 'env_api_domain'
        ENV['PROMISEPAY_USERNAME'] = 'env_username'
        ENV['PROMISEPAY_TOKEN'] = 'env_token'
        Promisepay.setup
      end

      after do
        ENV['PROMISEPAY_ENVIRONMENT'] = @cached_environment
        ENV['PROMISEPAY_API_DOMAIN'] = @cached_api_domain
        ENV['PROMISEPAY_USERNAME'] = @cached_useranme
        ENV['PROMISEPAY_TOKEN'] = @cached_token
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

  # describe 'queries' do

  #   let(:client_for_queries) { Promisepay::Client.new(username: 'myUsername', token: 'myToken') }

  #   describe 'get' do
  #     it 'returns a Faraday:Response' do
  #       expect(client_for_queries.get('')).to be_a(Faraday::response)
  #     end
  #   end
  # end

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

    # context 'when requests were previously made' do
    #   before { client.users.find_all }
    #   it 'is not empty' do
    #     expect(client.resources).to_not be_empty
    #   end
    #   it 'contains previosuly used resources' do
    #     expect(client.resources).to have_key(:users)
    #   end
    # end
  end

end
