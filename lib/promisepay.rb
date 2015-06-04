require_relative 'promisepay/client'
require_relative 'promisepay/default'
require_relative 'promisepay/version'

# Ruby toolkit for the Promisepay API
module Promisepay
  class << self
    include Promisepay::Configurable
  end
end

Promisepay.setup
