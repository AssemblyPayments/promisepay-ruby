require 'spec_helper'

describe Promisepay::Default do
  before { EnvironmentVariables.clean_up && Promisepay.setup }
  after { EnvironmentVariables.restore && Promisepay.setup }

  describe 'environment' do
    it 'has a default value' do
      expect(Promisepay::Default.const_defined?(:ENVIRONMENT)).to be(true)
      expect(Promisepay::Default.environment).not_to be_empty
    end
    it 'can be overwritten with an environment variable' do
      ENV['PROMISEPAY_ENVIRONMENT'] = 'production'
      expect(Promisepay::Default.environment).to eql('production')
    end
  end

  describe 'api_domain' do
    it 'has a default value' do
      expect(Promisepay::Default.const_defined?(:API_DOMAIN)).to be(true)
      expect(Promisepay::Default.api_domain).not_to be_empty
    end
    it 'can be overwritten with an environment variable' do
      ENV['PROMISEPAY_API_DOMAIN'] = 'custom.domain'
      expect(Promisepay::Default.api_domain).to eql('custom.domain')
    end
  end

  describe 'token' do
    it 'has no default value' do
      expect(Promisepay::Default.token).to be_nil
    end
    it 'can be overwritten with an environment variable' do
      ENV['PROMISEPAY_TOKEN'] = 'myToken'
      expect(Promisepay::Default.token).to eql('myToken')
    end
  end

  describe 'errors_format' do
    it 'has a default value' do
      expect(Promisepay::Default.errors_format).to eql('processed')
    end
    it 'can be overwritten with an environment variable' do
      ENV['PROMISEPAY_ERRORS_FORMAT'] = 'raw'
      expect(Promisepay::Default.errors_format).to eql('raw')
    end
  end

  describe 'username' do
    it 'has no default value' do
      expect(Promisepay::Default.username).to be_nil
    end
    it 'can be overwritten with an environment variable' do
      ENV['PROMISEPAY_USERNAME'] = 'myUsername'
      expect(Promisepay::Default.username).to eql('myUsername')
    end
  end

  describe 'options' do
    it 'returns an hash of options' do
      expect(Promisepay::Default.options).to be_a(Hash)
    end
    it 'returns correctly set options values' do
      ENV['PROMISEPAY_TOKEN'] = 'myToken'
      options = Promisepay::Default.options
      expect(options).to have_key(:token)
      expect(options[:token]).to eql('myToken')
    end
  end
end
