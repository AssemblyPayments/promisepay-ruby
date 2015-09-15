require 'spec_helper'

describe Promisepay::Company do
  let(:client) { Promisepay::Client.new }
  let(:company) { VCR.use_cassette('companies_multiple') { client.companies.find_all.first } }

  describe 'users' do
    context 'no user available', vcr: { cassette_name: 'companies_users_empty' } do
      it 'returns nil' do
        expect(companies.user).to be_nil
      end
    end

    context 'account available', vcr: { cassette_name: 'companies_users' } do
      it 'gives back a User' do
        expect(companies.user).to be_a(Promisepay::User)
      end
    end
  end
end