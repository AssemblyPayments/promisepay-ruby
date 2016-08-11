require 'spec_helper'

describe Promisepay::UserResource do
  let(:client) { Promisepay::Client.new }

  describe 'health_check' do
    it 'gives back a hash', vcr: { cassette_name: 'tools_health_check' } do
      health_check = client.tools.health_check
      expect(health_check).to be_a(Hash)
      expect(health_check).to have_key('status')
    end
  end
end
