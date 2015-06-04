require './lib/promisepay'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  # Filter out basic auth information from cassettes
  config.filter_sensitive_data('<USERNAME>') { ENV['PROMISEPAY_USERNAME'].gsub('@', '%40') }
  config.filter_sensitive_data('<TOKEN>') { ENV['PROMISEPAY_TOKEN'] }
end
