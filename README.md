# Ruby SDK - PromisePay API

[![Join the chat at https://gitter.im/PromisePay/promisepay-ruby](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/PromisePay/promisepay-ruby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Gem Version](https://badge.fury.io/rb/promisepay.svg)](http://badge.fury.io/rb/promisepay)
[![Build Status](https://travis-ci.org/PromisePay/promisepay-ruby.svg?branch=master)](https://travis-ci.org/PromisePay/promisepay-ruby)
[![Coverage Status](https://coveralls.io/repos/PromisePay/promisepay-ruby/badge.svg?branch=master)](https://coveralls.io/r/PromisePay/promisepay-ruby?branch=develop)
[![Code Climate](https://codeclimate.com/github/PromisePay/promisepay-ruby/badges/gpa.svg)](https://codeclimate.com/github/PromisePay/promisepay-ruby)

To see a completed integration in a Ruby on Rails app, visit this [repository](https://github.com/dannyshafer/PromisePay_api_integration).

# 1. Installation

Add these lines to your application's Gemfile:

```ruby
gem 'promisepay'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install promisepay

# 2. Configuration

Before interacting with Promispay API you need to generate an access token.

See [PromisePay documentation](https://docs.assemblypayments.com/feature-guides/integration/generating-api-keys/) for more information.

**Create a PromisePay client**

The client can be configured through environment variables.

```ruby
# In your environment file
PROMISEPAY_USERNAME ||= youremailaddress
PROMISEPAY_TOKEN ||= y0urt0k3n12345678910123456789101
```

The following parameters are configurable through the client:

  * `:username` / `ENV['PROMISEPAY_USERNAME']`: username for [basic authentication](https://docs.assemblypayments.com/feature-guides/integration/generating-api-keys/)
  * `:token` / `ENV['PROMISEPAY_TOKEN']`: token for [basic authentication](https://docs.assemblypayments.com/feature-guides/integration/generating-api-keys/)
  * `:environment` / `ENV['PROMISEPAY_ENVIRONMENT']`: API [environment](http://docs.assemblypayments.com/feature-guides/fundamentals/environments/) to use (default: 'test')
  * `:api_domain` / `ENV['PROMISEPAY_API_DOMAIN']`: API domain name to use (default: 'api.promisepay.com')

 Instantiate the PromisePay client.

```ruby
client = Promisepay::Client.new(username: ENV['PROMISEPAY_USERNAME'], token: ENV['PROMISEPAY_TOKEN'])
```

# 3. Examples

## Tokens
##### Example 1 - Request session token
The below example shows the controller request for a marketplace configured to have the Item and User IDs generated automatically for them. Note: by default, the ability to have PromisePay auto generate IDs is turned off. However, it can easily be requested by contacting PromisePay support.

```ruby
token_request = client.tokens.create(:session, {
  current_user: 'seller',
  item_name: 'Test Item',
  amount: '2500',
  seller_lastname: 'Seller',
  seller_firstname: 'Sally',
  buyer_lastname: 'Buyer',
  buyer_firstname: 'Bobby',
  buyer_country: 'AUS',
  seller_country: 'USA',
  seller_email: 'sally.seller@promisepay.com',
  buyer_email: 'bobby.buyer@promisepay.com',
  fee_ids: [],
  payment_type_id: 2
})
token = token_request['token']
item_id = token_request['item']
buyer_id = token_request['buyer']
seller_id = token_request['seller']
```
##### Example 2 - Request session token
The below example shows the request for a marketplace that passes the Item and User IDs.

```ruby
token = client.tokens.create(:session, {
  current_user_id: 'seller1234',
  item_name: 'Test Item',
  amount: '2500',
  seller_lastname: 'Seller',
  seller_firstname: 'Sally',
  buyer_lastname: 'Buyer',
  buyer_firstname: 'Bobby',
  buyer_country: 'AUS',
  seller_country: 'USA',
  seller_email: 'sally.seller@promisepay.com',
  buyer_email: 'bobby.buyer@promisepay.com',
  external_item_id: 'TestItemId1234',
  external_seller_id: 'seller1234',
  external_buyer_id: 'buyer1234',
  fee_ids: [],
  payment_type_id: 2
})['token']
```
## Items

##### Create an item
```ruby
item = client.items.create(
  id: '12345',
  name: 'test item for 5AUD',
  amount: '500',
  payment_type: '1',
  buyer_id: buyer.id,
  seller_id: seller.id,
  fee_ids: fee.id,
  description: '5AUD transfer'
)
```
##### Get an item
```ruby
item = client.items.find('1')
```
##### Get a list of items
```ruby
items = client.items.find_all
```
##### Update an item
```ruby
item.update(name: 'new name')
```
##### Cancel an item
```ruby
item.cancel
```
##### Get an item status
```ruby
item.status
```
##### Get an item's buyer
```ruby
item.buyer
```
##### Get an item's seller
```ruby
item.seller
```
##### Get an item's fees
```ruby
item.fees
```
##### Get an item's transactions
```ruby
item.transactions
```
##### Get an item's batch transactions
```ruby
item.batch_transactions
```
##### Get an item's wire details
```ruby
item.wire_details
```
##### Get an item's BPAY details
```ruby
item.bpay_details
```

## Users

##### Create a user
```ruby
user = client.users.create(
  id: '123456',
  first_name: 'test',
  last_name: 'buyer',
  email: 'buyer@test.com',
  address_line1: '48 collingwood',
  state: 'vic',
  city: 'Mel',
  zip: '3000',
  country: 'AUS',
  dob:'12/06/1980'
)
```
##### Update a user
```ruby
user = client.users.update(
  id: '123456',
  first_name: 'test',
  last_name: 'buyer',
  email: 'buyer@test.com',
  address_line1: '48 collingwood',
  state: 'vic',
  city: 'Mel',
  zip: '3000',
  country: 'AUS',
  dob:'12/06/1980'
)
```
##### Get a user
```ruby
user = client.users.find('1')
```
##### Get a list of users
```ruby
users = client.users.find_all
```
##### Get a user's card account
```ruby
user.card_account
```
##### Get a user's PayPal account
```ruby
user.paypal_account
```
##### Get a user's bank account
```ruby
user.bank_account
```
##### Get a user's wallet account
```ruby
user.wallet_account
```
##### Get a user's items
```ruby
user.items
```
##### Get a user's address
```ruby
user.address
```
##### Set a user's disbursement account
```ruby
user.disbursement_account(bank_account.id)
```
## Item Actions
##### Make payment
```ruby
item.make_payment(
  account_id: buyer_card_account.id
)
```
##### Request payment
```ruby
item.request_payment
```
##### Release payment
```ruby
item.release_payment
```
##### Request release
```ruby
item.request_release
```
##### Cancel
```ruby
item.cancel
```
##### Acknowledge wire
```ruby
item.acknowledge_wire
```
##### Acknowledge PayPal
```ruby
item.acknowledge_paypal
```
##### Revert wire
```ruby
item.revert_wire
```
##### Request refund
```ruby
item.request_refund(
  refund_amount: '1000',
  refund_message: 'because'
)
```
##### Decline refund
```ruby
item.decline_refund
```
##### Refund
```ruby
item.refund(
  refund_amount: '1000',
  refund_message: 'because'
)
```
##### Raise dispute
```ruby
item.raise_dispute(user_id: '5830def0-ffe8-11e5-86aa-5e5517507c66')
```
##### Request resolve dispute
```ruby
item.request_resolve_dispute
```
##### Resolve dispute
```ruby
item.resolve_dispute
```
##### Escalate dispute
```ruby
item.escalate_dispute
```
##### Send tax invoice
```ruby
item.send_tax_invoice
```
##### Request tax invoice
```ruby
item.request_tax_invoice
```
## Card Accounts
##### Create a card account
```ruby
card_account = client.card_accounts.create(
  user_id: buyer.id,
  full_name: 'test Buyer',
  number: '4111 1111 1111 1111',
  expiry_month: Time.now.month,
  expiry_year: Time.now.year + 1,
  cvv: '123'
)
```
##### Get a card account
```ruby
card_account = client.card_accounts.find('1')
```
##### Deactivate a card account
```ruby
card_account.deactivate
```
##### Get a card account's users
```ruby
card_account.user
```

## Bank Accounts
##### Create a bank account
```ruby
bank_account = client.bank_accounts.create(
  user_id: seller.id,
  bank_name: 'Nab',
  account_name: 'test seller',
  routing_number: '22222222',
  account_number: '1234567890',
  account_type: 'savings',
  holder_type: 'personal',
  country: 'AUS'
)
```
##### Get a bank account
```ruby
bank_account = client.bank_accounts.find('1')
```
##### Deactivate a bank account
```ruby
bank_account.deactivate
```
##### Get a bank account's users
```ruby
bank_account.user
```
##### Validate Routing Number
```ruby
client.bank_accounts.validate('122235821')
```

## PayPal Accounts
##### Create a PayPal account
```ruby
paypal_account = client.paypal_accounts.create(
  user_id: seller.id,
  paypal_email: 'seller@promisepay.com'
)
```
##### Get a PayPal account
```ruby
paypal_account = client.paypal_accounts.find('1')
```
##### Deactivate a PayPal account
```ruby
paypal_account.deactivate
```
##### Get a PayPal account's users
```ruby
paypal_account.user
```

## Wallet Accounts
##### Get a Wallet account
```ruby
wallet_account = client.wallet_accounts.find('1')
```
##### Deposit funds
```ruby
wallet_account.deposit(
  account_id: '123',
  amount: 500
)
```
##### Withdraw funds
```ruby
wallet_account.withdraw(
  account_id: '123',
  amount: 200
)
```
##### Get a Wallet account's users
```ruby
wallet_account.user
```

## Companies

##### Create a company
```ruby
client.companies.create(
  user_id: "1",
  name: "Acme Co",
  legal_name: "Acme Co Pty Ltd",
  tax_number: "1231231",
  charge_tax: true,
  address_line1: "123 Test St",
  address_line2: "",
  city: "Melbourne",
  state: "VIC",
  zip: "3000",
  country: "AUS"
)
```

##### Get a company
```ruby
client.companies.find('compamy_id')
```

##### Get a list of companies
```ruby
client.companies.find_all
```

##### Get a company's address
```ruby
company.address
```

##### Update a company
```ruby
client.companies.update(
  id: "8d578b9c-5b79-11e5-885d-feff819cdc9f",
  name: "Acme Co",
  legal_name: "Acme Co Pty Ltd",
  tax_number: "1231231",
  charge_tax: true,
  address_line1: "123 Test St",
  address_line2: "",
  city: "Melbourne",
  state: "VIC",
  zip: "3000",
  country: "AUS"
)
```

## Fees
##### Get a list of fees
```ruby
fees = client.fees.find_all
```
##### Get a fee
```ruby
fees = client.fees.find('1')
```
##### Create a fee
```ruby
fee = client.fees.create(
  name: 'test fee for 5 AUD',
  fee_type_id: '1',
  amount: '75',
  to: 'seller'
)
```

## Transactions
##### Get a list of transactions
```ruby
transactions = client.transactions.find_all
```
##### Get a transaction
```ruby
transaction = client.transactions.find('1')
```
##### Get a transaction's users
```ruby
transaction.users
```
##### Get a transaction's fees
```ruby
transaction.fees
```

## Batch Transactions
##### Get a list of batch transactions
```ruby
batch_transactions = client.batch_transactions.find_all
```
##### Get a transaction
```ruby
batch_transaction = client.batch_transactions.find('1')
```

## Charges
##### Get a list of charges
```ruby
charges = client.charges.find_all
```
##### Get a charge
```ruby
charge = client.charges.find('1')
```
##### Create a charge
```ruby
charge = client.charges.create(
  account_id: '123',
  user_id: '456',
  name: 'Charge for Delivery',
  email: 'anonymous+buyer+1@promisepay.com',
  amount: 4_500,
  zip: '3000',
  curency: 'AUD',
  country: 'AUS',
  retain_account: true,
  device_id: '0900JapG4txqVP4Nf...',
  ip_address: '172.16.81.100'
)
```
##### Get a charge's buyer
```ruby
charge.buyer
```
##### Get a charge's status
```ruby
charge.status
```

## Direct Debit Authority
##### Get a list of direct debit authorities for a given account
```ruby
bank_account = client.bank_accounts.find('9fda18e7-b1d3-4a83-830d-0cef0f62cd25')
ddas = client.charges.find_all(bank_account.id)
```
##### Get a direct debit authority
```ruby
dda = client.direct_debit_authorities.find('8f233e04-ffaa-4c9d-adf9-244853848e21')
```
##### Create a direct debit authority
```ruby
charge = client.direct_debit_authorities.create(
  account_id: '9fda18e7-b1d3-4a83-830d-0cef0f62cd25',
  amount: '10000'
)
```
##### Delete a direct debit authority
```ruby
dda = client.direct_debit_authorities.find('8f233e04-ffaa-4c9d-adf9-244853848e21')
dda.delete
```

## Tools
##### Health check
```ruby
client.tools.health_check
```
## Marketplace
```ruby
client.marketplace
```

## Token
##### Generate
```ruby
client.generate_token(token_type: 'card', user_id: '5830def0-ffe8-11e5-86aa-5e5517507c66')
```

_Check out the [online documentation](http://promisepay.github.io/promisepay-ruby/) to get a full list of available resources and methods._


## Direct API Calls (that are missing as model methods)
##### Example: Search user by email (or any text in user's profile)
```ruby
JSON.parse client.get("users",{search: "test@test.com"}).body
```


# 4. Contributing

  1. Fork it ( https://github.com/PromisePay/promisepay-ruby/fork )
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create a new Pull Request
