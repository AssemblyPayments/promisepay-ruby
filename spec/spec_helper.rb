require './lib/promisepay'
require 'webmock/rspec'
require 'vcr'
require 'coveralls'
Coveralls.wear!

# Require supporting ruby files for specs in spec/support/ and its subdirectories.
Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.include EnvironmentVariables
end

raise 'missing PROMISEPAY_USERNAME environment variable' if ENV['PROMISEPAY_USERNAME'].nil?
raise 'missing PROMISEPAY_TOKEN environment variable' if ENV['PROMISEPAY_TOKEN'].nil?

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  # Filter out basic auth information in cassettes
  config.filter_sensitive_data('<USERNAME>') { ENV['PROMISEPAY_USERNAME'].gsub('@', '%40') }
  config.filter_sensitive_data('<TOKEN>') { ENV['PROMISEPAY_TOKEN'].gsub('=','%3D') }
end
