require 'spec_helper'

describe Promisepay::BaseResource do
  let(:client) { Promisepay::Client.new }

  describe 'initalize' do
    it 'needs a client' do
      resource = Promisepay::BaseResource.new(client)
      expect(resource.instance_variable_get(:@client)).to be_a(Promisepay::Client)
    end
  end
end
