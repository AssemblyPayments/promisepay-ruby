# The Promisepay Ruby Gem

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

You can generate a client as following:

```ruby
client = Promisepay::Client.new(username: 'YOUR_USERNAME', token: 'YOUR_TOKEN')
```
  
Alternatively Promisepay Gem handles client configuration through environment variables.
```ruby
ENV['PROMISEPAY_USERNAME'] = 'YOUR_USERNAME'
ENV['PROMISEPAY_TOKEN'] = 'YOUR_TOKEN'
```

```ruby
client = Promisepay::Client.new()
```
  
_To get a list of all client configurable parameter check out the [Client Configuration section](#client_conf)._

##<a name="client_conf"></a> Client Configuration

The following parameters are configurable through the client:
  * `:username` / `ENV['PROMISEPAY_USERNAME']`: username for [basic authentication](http://docs.promisepay.com/v2.2/docs/overview-2) 
  * `:token` / `ENV['PROMISEPAY_TOKEN']`: token for [basic authentication](http://docs.promisepay.com/v2.2/docs/overview-2)
  * `:environment` / `ENV['PROMISEPAY_ENVIRONMENT']`: API [environment](http://docs.promisepay.com/v2.2/docs/environments) to use (default: 'test')
  * `:api_domain` / `ENV['PROMISEPAY_API_DOMAIN']`: API domain name to use (default: 'api.promisepay.com')
  
## Contributing

1. Fork it ( https://github.com/[my-github-username]/promisepay-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
