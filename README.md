# The PromisePay Ruby Gem
[![Gem Version](https://badge.fury.io/rb/promisepay.svg)](http://badge.fury.io/rb/promisepay)
[![Build Status](https://travis-ci.org/PromisePay/promisepay-ruby.svg?branch=develop)](https://travis-ci.org/PromisePay/promisepay-ruby)
[![Coverage Status](https://coveralls.io/repos/PromisePay/promisepay-ruby/badge.svg?branch=develop)](https://coveralls.io/r/PromisePay/promisepay-ruby?branch=develop)
[![Code Climate](https://codeclimate.com/github/PromisePay/promisepay-ruby/badges/gpa.svg)](https://codeclimate.com/github/PromisePay/promisepay-ruby)

A Ruby interface to the Promisepay API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'promisepay'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install promisepay

## Usage

Before interacting with Promispay API you need to generate an access token.

See http://docs.promisepay.com/v2.2/docs/request_token for more information.

### Client

Create a client as following:

```ruby
require 'promisepay'

client = Promisepay::Client.new(username: 'YOUR_USERNAME', token: 'YOUR_TOKEN')
```

Alternatively Promisepay Gem handles client configuration through environment variables.

```ruby
ENV['PROMISEPAY_USERNAME'] = 'YOUR_USERNAME'
ENV['PROMISEPAY_TOKEN'] = 'YOUR_TOKEN'
```

```ruby
require 'promisepay'

client = Promisepay::Client.new()
```

_All configurable parameters are available in the Client Configuration section of this README._

### Calls

The example below is translating [use case #1](http://docs.promisepay.com/v2.2/docs/charge-a-buyer-hold-funds-in-escrow-then-release-t) available on Promispay online documentation.

```ruby
# 1- Create buyer
buyer = client.users.create(
  id: '123456',
  first_name: 'test',
  last_name: 'buyer',
  email: 'buyer@test.com',
  address_line1: '48 collingwood',
  state: 'vic',
  city: 'Mel',
  zip: '3000',
  country: 'AUS'
)

# 2- Create buyer's card account
buyer_card_account = client.card_accounts.create(
  user_id: buyer.id,
  full_name: 'test Buyer',
  number: '4111 1111 1111 1111',
  expiry_month: Time.now.month,
  expiry_year: Time.now.year + 1,
  cvv: '123'
)

# 3- Create seller
seller = client.users.create(
  id: '123457',
  first_name: 'test',
  last_name: 'seller',
  email: 'seller@test.com',
  mobile: '+61416452321',
  address_line1: 'abc',
  state: 'vic',
  city: 'Mel',
  zip: '3000',
  country: 'AUS'
)

# 4- Create seller's bank account
seller_bank_account = client.bank_accounts.create(
  user_id: seller.id,
  bank_name: 'Nab',
  account_name: 'test seller',
  routing_number: '22222222',
  account_number: '1234567890',
  account_type: 'savings',
  holder_type: 'personal',
  country: 'AUS'
)

# 5. Create seller's disbursement account
seller.disbursement_account(seller_bank_account.id)

# 6. Create fee
fee = client.fees.create(
  name: 'test fee for 5 AUD',
  fee_type_id: '1',
  amount: '75',
  to: 'seller'
)

# 7. Create item and link buyer, seller and fee to it
item = client.items.create(
  id: '12345',
  name: 'test item for 5AUD',
  amount: '500',
  payement_type: '1',
  buyer_id: buyer.id,
  seller_id: seller.id,
  fee_id: fee.id,
  description: '5AUD transfer'
)

# 8. Pay for item using the buyer's CC account
item.make_payment(
  user_id: buyer.id,
  account_id: buyer_card_account.id
)

# 9. Buyer releases payment
item.release_payment(user_id: buyer.id)

# 10. Check payment status at any time (optional)
item.status
```

_Check out the [online documentation](http://promisepay.github.io/promisepay-ruby/) to get a list of available resources and methods._

## Client Configuration

The following parameters are configurable through the client:

  * `:username` / `ENV['PROMISEPAY_USERNAME']`: username for [basic authentication](http://docs.promisepay.com/v2.2/docs/overview-2)
  * `:token` / `ENV['PROMISEPAY_TOKEN']`: token for [basic authentication](http://docs.promisepay.com/v2.2/docs/overview-2)
  * `:environment` / `ENV['PROMISEPAY_ENVIRONMENT']`: API [environment](http://docs.promisepay.com/v2.2/docs/environments) to use (default: 'test')
  * `:api_domain` / `ENV['PROMISEPAY_API_DOMAIN']`: API domain name to use (default: 'api.promisepay.com')

## Contributing

1. Fork it ( https://github.com/PromisePay/promisepay-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
