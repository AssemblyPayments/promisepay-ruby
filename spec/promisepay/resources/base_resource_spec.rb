require 'spec_helper'

describe Promisepay::BaseResource do
  describe 'initalize' do
    it 'needs a client' do
      client = Promisepay::Client.new
      resource = Promisepay::BaseResource.new(client)
      expect(resource.instance_variable_get(:@client)).to be_a(Promisepay::Client)
    end
  end
end
