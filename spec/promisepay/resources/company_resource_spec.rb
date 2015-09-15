require 'spec_helper'

describe Promisepay::CompanyResource do
  let(:client) { Promisepay::Client.new }

  describe 'find' do
    let(:single_company) { VCR.use_cassette('companies_multiple') { client.companies.first } }

    context 'an existing company', vcr: { cassette_name: 'companies_single' } do
      it 'gives back a single company' do
        user = client.companies.find(single_company.id)
        expect(user).to be_a(Promisepay::Company)
      end
    end

    context 'an unknown company', vcr: { cassette_name: 'companies_unknown' } do
      it 'raises an error' do
        expect { client.companies.find('unkown_id') }.to raise_error(Promisepay::Unauthorized)
      end
    end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'companies_created' } do
      let(:valid_attributes) do
        {
          id: '99',
          first_name: 'myFirstName',
          email: 'firstname@email.com',
          country: 'AUS'
        }
      end

      it 'gives back a user' do
        user = client.companies.create(valid_attributes)
        expect(user).to be_a(Promisepay::Company)
        expect(user.id).to eql('99')
        expect(user.first_name).to eql('myFirstName')
        expect(user.email).to eql('firstname@email.com')
        expect(user.location).to eql('AUS')
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'companies_created_error' } do
      let(:invalid_attributes) { { email: 'notAnEmail' } }

      it 'raises an error' do
        expect {
          client.companies.create(invalid_attributes)
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'Company methods' do
    it 'can be accessed' do
      expect(client.companies.respond_to?(:items)).to be(true)
    end
  end
end