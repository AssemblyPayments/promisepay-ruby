require 'spec_helper'

describe Promisepay::ChargeResource do
  let(:client) { Promisepay::Client.new }

  describe 'find_all' do
    context 'when no charges are available', vcr: { cassette_name: 'charges_empty'} do
      it 'gives back an empty array' do
        expect(client.charges.find_all).to be_empty
      end
    end

    context 'when charges are available', vcr: { cassette_name: 'charges_multiple'} do
      before { PromisepayFactory.create_charge }
      it 'gives back an array of charges' do
        charges = client.charges.find_all
        expect(charges).not_to be_empty
        expect(charges.first).to be_a(Promisepay::Charge)
      end
    end
  end

  describe 'find' do
    context 'an existing charge', vcr: { cassette_name: 'charges_single' } do
      let(:existing_charge) { PromisepayFactory.create_charge }
      it 'gives back a single charge' do
        charge = client.charges.find(existing_charge.id)
        expect(charge).to be_a(Promisepay::Charge)
      end
    end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'charges_created' } do
      let(:user) { PromisepayFactory.create_user }
      let(:account) { PromisepayFactory.create_card_account({}, user) }
      let(:valid_attributes) do
        {
          account_id: account.id,
          user_id: user.id,
          name: 'Charge for Delivery',
          email: 'anonymous+buyer+1@promisepay.com',
          amount: 4_500,
          zip: '3000',
          curency: 'AUD',
          country: 'AUS',
          retain_account: true,
          device_id: '0900JapG4txqVP4Nf94lis1ztmY64bRzRufIskMqKRxYZWFibp4j/+DwRPTztbpmYmDn9n3uDZG7y79QuA+jSTdt2mU8BZeT94rSue+B4M2wkqImINsJ9VlMYGTX23I2zuDzEYngAz99aSN3ySC3tvRP4YCTJbtlNWlumGODXWbkrLSLP/wT3etan16/FINOuYS5LH/sQ/sXqk0yDUQkBm21+3hdrSzenwv2iK7pMCw9zdRN+3jlt//OauTQHjy7H5XhLHCHAGY3J0jpLqVrSVzsI1LB6M5fl2EoMEAoEitEttFUo1DRkUtPGPRhfRZSJgi/2XEcZH+tN3R4VShbY+EVBD6upMsx8e+4a0Yy5JnHYpPz7R1zkAHAFKeaPzHTB6yLaYIZf7bM7FD9I4jOJ33S01NZtVmpaU+ltXRybJL065B3xBfNPgHEB08CRvIVZ/7OW/kWLcmvNeDVSi9QfH7TEmxGFWkS2PTjdOIYgHC/3QaUBo+BORdkpO8mR20/oWqfaTXAiPJhDc7Kf2hhwqstJ+rhabIcxurYS9YOYuyRGpb/IognXxhY6dXh35GdB6Cc0rdKBra3m4ajKT2dl0HzU5BUzQgct4fSViSftA9S4WN+/u06EOo/UEYn9EFMRfvxVguGdCj5lheliCBIlujE9p5bObFITgxo+snP9+SWhwwQjHzFmjZC2x3+Dd6SKNck3/+IBhtGeSxQ+x3bbPGSKlPeImNr/UVPV6i8/tb5alAK/XRNo3H5dCCofHI9aHmKGVsh1GZGb/t+MWh63oYq0hpEwt3pHbVYAH9NfWd7xUnvIFC6f0yZnUxJtZ1tiSkVcDDQDXXUEycmHIUb3cIYInqn0vWZ4E9DERA11M8IkCuPI7c/6cZ+WudVvu4eBdAZLc3MKdVnbnSmjIkq5qftS7QndrGGVnAk80aKvKixGUf6oxNEfoZFV+S24ttMGG6sXUx2ddU5OPCCOX680qzq/uUq87u17lXRMFdx4wimxQE05lyt1veYpHNuv7sghWOEeioIZRnmC0W+ochQziz7ftZJCaKwymxS1wfmZzpno82u3Z2HQd3V4wfJ/zck+QECqJOz7YCWoR/mx2vNwg2Qek4/nm8ErLEbx5REX5I2a/52aev9sHy3VFGNJrl9WRwxtuSe+IVmUVHMK436hmn9pJQL8E0wyEGvoAODQNpCPDLzpW3aa+9Wp5YstdZ3m/rUv5dztqLbo6mZ2MNz4rLVKY4TfJCS0UoHWAVvYG/EH/md2OpxAZVeiYsco/z52WqDHt7uDpkIrv9JRPmShTpHVC2Al7FLtDsZ',
          ip_address: '172.16.81.100'
        }
      end

      it 'gives back a charge' do
        charge = client.charges.create(valid_attributes)
        expect(charge).to be_a(Promisepay::Charge)
        expect(charge.name).to eql('Charge for Delivery')
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'charges_created_error' } do
      let(:invalid_attributes) { { name: 'Charge for Delivery' } }
        it 'raises an error' do
          expect {
            client.charges.create(invalid_attributes)
          }.to raise_error(Promisepay::UnprocessableEntity)
        end
    end
  end

  describe 'charges methods' do
    it 'can be accessed' do
      expect(client.charges.respond_to?(:buyer)).to be(true)
    end
  end
end
