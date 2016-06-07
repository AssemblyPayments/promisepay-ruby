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

  private

  def self.client
    Promisepay::Client.new
  end
end
