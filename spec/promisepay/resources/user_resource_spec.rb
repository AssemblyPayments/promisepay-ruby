require 'spec_helper'

describe Promisepay::UserResource do
  let(:client) { Promisepay::Client.new }

  describe 'find_all' do
    context 'when no users are available', vcr: { cassette_name: 'users_empty' } do
      it 'gives back an empty array' do
        users = client.users.find_all
        expect(users).to be_empty
      end
    end

    context 'when multiple users are available', vcr: { cassette_name: 'users_multiple' } do
      it 'gives back an array of users' do
        users = client.users.find_all
        expect(users).to_not be_empty
        expect(users.first).to be_a(Promisepay::User)
      end
    end
  end

  describe 'find' do
    context 'an existing user', vcr: { cassette_name: 'users_single' } do
      it 'gives back a single user' do
        user = client.users.find('1')
        expect(user).to be_a(Promisepay::User)
      end
    end

    context 'an unknown user', vcr: { cassette_name: 'users_unknown' } do
      it 'raises an error' do
        expect { client.users.find('unkown_id') }.to raise_error(Promisepay::Unauthorized)
      end
    end
  end

  describe 'create' do
    context 'with valid attributes', vcr: { cassette_name: 'users_created' } do
      let(:valid_attributes) do
        {
          id: '99',
          first_name: 'myFirstName',
          email: 'firstname@email.com',
          country: 'AUS'
        }
      end

      it 'gives back a user' do
        user = client.users.create(valid_attributes)
        expect(user).to be_a(Promisepay::User)
        expect(user.id).to eql('99')
        expect(user.first_name).to eql('myFirstName')
        expect(user.email).to eql('firstname@email.com')
        expect(user.location).to eql('AUS')
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'users_created_error' } do
      let(:invalid_attributes) { { email: 'notAnEmail' } }

      it 'raises an error' do
        expect {
          client.users.create(invalid_attributes)
        }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'User methods' do
    it 'can be accessed' do
      expect(client.users.respond_to?(:items)).to be(true)
    end
  end
end
