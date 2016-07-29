require 'spec_helper'

describe Promisepay::Company do
  let(:company) { PromisepayFactory.create_user }

  describe 'address', vcr: { cassette_name: 'company_address'} do
    it 'returns a Hash' do
      address = company.address
      expect(address).to be_a(Hash)
      expect(address).to have_key('addressline1')
      expect(address).to have_key('country')
    end
  end
end
