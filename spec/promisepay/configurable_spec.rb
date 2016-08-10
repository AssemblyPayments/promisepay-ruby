require 'spec_helper'

describe Promisepay::Configurable do
  it 'has a list of configurable options' do
    expect(Promisepay::Configurable.keys).to include(:api_domain)
    expect(Promisepay::Configurable.keys).to include(:environment)
    expect(Promisepay::Configurable.keys).to include(:errors_format)
    expect(Promisepay::Configurable.keys).to include(:username)
    expect(Promisepay::Configurable.keys).to include(:token)
  end
end
