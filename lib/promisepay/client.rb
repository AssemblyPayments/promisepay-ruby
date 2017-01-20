require_relative 'configurable'
require_relative 'error'
require_relative 'models/base_model'
require_relative 'models/account'
require_relative 'models/bank_account'
require_relative 'models/batch_transaction'
require_relative 'models/callback'
require_relative 'models/card_account'
require_relative 'models/charge'
require_relative 'models/company'
require_relative 'models/direct_debit_authority'
require_relative 'models/fee'
require_relative 'models/item'
require_relative 'models/paypal_account'
require_relative 'models/transaction'
require_relative 'models/user'
require_relative 'models/wallet_account'
require_relative 'resources/base_resource'
require_relative 'resources/account_resource'
require_relative 'resources/bank_account_resource'
require_relative 'resources/batch_transaction_resource'
require_relative 'resources/callback_resource'
require_relative 'resources/card_account_resource'
require_relative 'resources/charge_resource'
require_relative 'resources/company_resource'
require_relative 'resources/fee_resource'
require_relative 'resources/direct_debit_authority_resource'
require_relative 'resources/item_resource'
require_relative 'resources/paypal_account_resource'
require_relative 'resources/token_resource'
require_relative 'resources/transaction_resource'
require_relative 'resources/user_resource'
require_relative 'resources/wallet_account_resource'
require_relative 'tool'
require 'json'
require 'faraday'

module Promisepay
  # Client for the Promisepay API
  #
  # @see http://docs.promisepay.com/v2.2/docs/overview
  class Client
    include Promisepay::Configurable

    def initialize(options = {})
      # Use options passed in, but fall back to module defaults
      Promisepay::Configurable.keys.each do |key|
        instance_variable_set(
          :"@#{key}", options[key] || Promisepay.instance_variable_get(:"@#{key}")
        )
      end
    end

    # Create a new Faraday connection
    #
    # @return [Faraday::Connection]
    def connection
      Faraday.new(url: @api_endpoint) do |builder|
        builder.request :basic_auth, @username, @token
        builder.adapter :net_http
      end
    end

    # Make a HTTP GET request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param parameters [Hash] Query params for request
    # @return [Faraday::Response]
    def get(url, parameters = {}, skip_status_check = false)
      response = connection.get("#{api_endpoint}#{url}", parameters)
      on_complete(response) unless skip_status_check
      response
    end

    # Make a HTTP POST request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param parameters [Hash] Query params for request
    # @return [Faraday::Response]
    def post(url, parameters = {})
      response = connection.post do |req|
        req.url "#{api_endpoint}#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = parameters.to_json
      end
      on_complete(response)
      response
    end

    # Make a HTTP PATCH request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param parameters [Hash] Query params for request
    # @return [Faraday::Response]
    def patch(url, parameters = {})
      response = connection.patch do |req|
        req.url "#{api_endpoint}#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = parameters.to_json
      end
      on_complete(response)
      response
    end

    # Make a HTTP DELETE request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param parameters [Hash] Query params for request
    # @return [Faraday::Response]
    def delete(url, parameters = {})
      response = connection.delete do |req|
        req.url "#{api_endpoint}#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = parameters.to_json
      end
      on_complete(response)
      response
    end

    # Show details of your Platform.
    #
    # @see https://reference.promisepay.com/#show-marketplace
    #
    # @return [Hash]
    def marketplace
      JSON.parse(get('marketplace').body)['marketplaces']
    end

    # Available resources for {Client}
    #
    # @return [Hash]
    def self.resources
      {
        bank_accounts: BankAccountResource,
        batch_transactions: BatchTransactionResource,
        callbacks: CallbackResource,
        card_accounts: CardAccountResource,
        charges: ChargeResource,
        companies: CompanyResource,
        direct_debit_authorities: DirectDebitAuthorityResource,
        fees: FeeResource,
        items: ItemResource,
        paypal_accounts: PaypalAccountResource,
        transactions: TransactionResource,
        users: UserResource,
        tokens: TokenResource,
        tools: Tool,
        wallet_accounts: WalletAccountResource
      }
    end

    # Catch calls for resources
    #
    def method_missing(name, *args, &block)
      if self.class.resources.keys.include?(name)
        resources[name] ||= self.class.resources[name].new(self)
        resources[name]
      else
        super
      end
    end

    # Resources being currently used
    #
    # @return [Hash]
    def resources
      @resources ||= {}
    end

    # Create a card token that can be used with the PromisePay.js package
    # to securely send PromisePay credit card details.
    #
    # @param options [Hash] Optional options.
    # @option options [String] :token_type token type ID.
    # @option user_id [String] :user_id Buyer or Seller ID (already created).
    #
    # @return [Hash]
    def generate_token(options)
      response = JSON.parse(post("token_auths", options).body)
      response['token_auth']
    end

    private

    def on_complete(response)
      fail Promisepay::Error.from_response(response, @errors_format) unless response.success?
    end
  end
end
