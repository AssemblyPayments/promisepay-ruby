require 'spec_helper'

describe Promisepay::Company do
  let(:client) { Promisepay::Client.new }
  let(:company) { VCR.use_cassette('companies_multiple') { client.companies.find_all.first } }

end