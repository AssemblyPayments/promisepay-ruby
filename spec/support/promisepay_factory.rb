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

  private

  def self.client
    Promisepay::Client.new
  end
end
