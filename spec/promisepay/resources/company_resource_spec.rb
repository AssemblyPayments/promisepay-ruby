require 'spec_helper'

describe Promisepay::CompanyResource do
  let(:client) { Promisepay::Client.new }

  describe 'find' do
    let(:single_company) { VCR.use_cassette('companies_multiple') { client.companies.find_all.first } }

    context 'an existing company', vcr: { cassette_name: 'companies_single' } do
      it 'gives back a single company' do
        user = client.companies.find(single_company.id)
        expect(user).to be_a(Promisepay::Company)
      end
    end

    context 'an unknown company', vcr: { cassette_name: 'companies_unknown_find' } do
      it 'raises an error' do
        expect { client.companies.find('unknown_id') }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'companies_created' } do
      let(:valid_attributes) do
        {
          user_id: '1',
          name: 'Company Name',
          legal_name: 'Legal Name',
          country: 'AUS'
        }
      end

      it 'gives back a company' do
        company = client.companies.create(valid_attributes)
        expect(company).to be_a(Promisepay::Company)
        expect(company.name).to eql('Company Name')
        expect(company.legal_name).to eql('Legal Name')
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

  # describe 'update' do
  #   let!(:company) { PromisepayFactory.create_company }
  #   context 'with valid attributes', vcr: { cassette_name: 'companies_updated' } do
  #     let(:attributes) { { id: company.id, name: 'new company name' } }

  #     it 'updates the company' do
  #       company = client.companies.update(attributes)
  #       expect(company).to be_a(Promisepay::Company)
  #       expect(company.name).to eql('new company name')
  #     end
  #   end
  # end
end
