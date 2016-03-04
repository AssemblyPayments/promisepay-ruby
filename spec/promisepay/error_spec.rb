require 'spec_helper'

describe Promisepay::Error do
  describe "from_response" do
    it "returns an error with formatted message" do
      response = double(Faraday::Response, status: 422, body: "{\"errors\":{\"name\":[\"can't be blank\",\"required field missing\"],\"principal.firstname\":[\"can't be blank\"],\"principal.email\":[\"is invalid\"],\"principal.mobile\":[\"already exists\"],\"principal\":[\"is invalid\"]}}")
      error = Promisepay::Error.from_response(response)
      expect(error.message).to eq "name: can't be blank, required field missing, principal.firstname: can't be blank, principal.email: is invalid, principal.mobile: already exists, principal: is invalid"
    end
  end
end
