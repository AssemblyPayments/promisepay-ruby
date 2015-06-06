require 'spec_helper'

describe Promisepay::BaseModel do
  let(:client) { Promisepay::Client.new }

  describe 'initalize' do
    it 'needs a client' do
      model = Promisepay::BaseModel.new(client)
      expect(model.instance_variable_get(:@client)).to be_a(Promisepay::Client)
    end
  end

  describe 'attributes' do
    let(:attributes) { { 'name' => 'myName', 'email' => 'myname@email.com' } }
    let(:model) { Promisepay::BaseModel.new(client, attributes) }

    it 'can be accessed' do
      expect(model.name).to eql('myName')
      expect(model.email).to eql('myname@email.com')
    end
  end
end
