module PromisepayFactory

  def self.create_user options={}
    random_id = SecureRandom.uuid
    default_options = {
      id: random_id,
      first_name: 'myFirstName',
      email: "#{random_id}@mail.com",
      country: 'AUS'
    }
    client.users.create(default_options.merge(options))
  end

  def self.create_item options={}, seller=nil, buyer=nil
    seller = create_user if seller.nil?
    buyer = create_user if buyer.nil?

    default_options = {
      id: SecureRandom.uuid,
      name: 'itemName',
      amount: 500,
      payment_type: 1,
      seller_id: seller.id,
      buyer_id: buyer.id,
    }
    client.items.create(default_options.merge(options))
  end

  def self.create_card_account options={}, owner=nil
    owner = create_user if owner.nil?

    default_options = {
      user_id: owner.id,
      full_name: 'User Name',
      number: '4111111111111111',
      expiry_month: Time.now.month,
      expiry_year: Time.now.year + 1,
      cvv: '123'
    }
    client.card_accounts.create(default_options.merge(options))
  end

  def self.create_bank_account options={}, owner=nil
    owner = create_user if owner.nil?

    default_options = {
      user_id: owner.id,
      bank_name: 'myBank',
      account_name: 'myAccount',
      routing_number: '123123',
      account_number: '12341234',
      account_type: 'savings',
      holder_type: 'personal',
      country: 'AUS',
      mobile_pin: '123456'
    }
    client.bank_accounts.create(default_options.merge(options))
  end

  def self.create_paypal_account options={}, owner=nil
    owner = create_user if owner.nil?

    default_options = {
      user_id: owner.id,
      paypal_email: owner.email
    }
    client.paypal_accounts.create(default_options.merge(options))
  end

  def self.create_fee options={}
    default_options = {
      fee_type_id: '1', # Fixed
      name: 'feeName',
      amount: 500,
      to: 'buyer'
    }
    client.fees.create(default_options.merge(options))
  end

  def self.create_company options={}
    default_options = {
      name: "Samuel's Gardening",
      legal_name: "Samuel's Gardening Pty Ltd",
      user_id: '',
      tax_number: '100200300',
      charge_tax: false,
      address_line1: '500 Garden St',
      address_line2: '',
      city: 'Sydney',
      state: 'NSW',
      zip: '2000',
      country: 'AUS',
      phone: '+61491570156'
    }
    client.companies.create(default_options.merge(options))
  end

  def self.create_charge options={}, account=nil, user=nil
    account = create_card_account if account.nil?
    user_id = (user.nil?) ? nil : user.id

    default_options = {
      account_id: account.id,
      user_id: user_id,
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
    client.charges.create(default_options.merge(options))
  end

  def self.create_direct_debit_authority options={}, account=nil
    account = create_bank_account if account.nil?

    default_options = {
      account_id: account.id,
      amount: '100000'
    }
    client.direct_debit_authorities.create(default_options.merge(options))
  end

  private

  def self.client
    Promisepay::Client.new
  end
end
