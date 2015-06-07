require_relative 'configurable'
require_relative 'models/base_model'
require_relative 'models/item'
require_relative 'models/user'
require_relative 'resources/base_resource'
require_relative 'resources/item_resource'
require_relative 'resources/user_resource'
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
    def get(url, parameters = {})
      connection.get("#{api_endpoint}#{url}", parameters)
    end

    # Make a HTTP POST request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param parameters [Hash] Query params for request
    # @return [Faraday::Response]
    def post(url, parameters = {})
      connection.post do |req|
        req.url "#{api_endpoint}#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = parameters.to_json
      end
    end

    # Make a HTTP PATCH request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param parameters [Hash] Query params for request
    # @return [Faraday::Response]
    def patch(url, parameters = {})
      connection.patch do |req|
        req.url "#{api_endpoint}#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = parameters.to_json
      end
    end

    # Make a HTTP DELETE request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param parameters [Hash] Query params for request
    # @return [Faraday::Response]
    def delete(url, parameters = {})
      connection.delete do |req|
        req.url "#{api_endpoint}#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = parameters.to_json
      end
    end

    # Available resources for {Client}
    #
    # @return [Hash]
    def self.resources
      {
        items: ItemResource,
        users: UserResource
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
  end
end
