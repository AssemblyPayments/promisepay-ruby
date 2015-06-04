require 'spec_helper'

# describe Promisepay::Client::UserResource do

#   let(:client) { Promisepay::Client.new }

#   describe 'find_all' do
#     context 'when no users are available', vcr: { cassette_name: 'users_empty' } do
#       it 'gives back an empty array' do
#         users = client.users.find_all
#         expect(users).to be_empty
#       end
#     end

#     context 'when multiple are available', vcr: { cassette_name: 'users_multiple' } do
#       it 'gives back an array of Users' do
#         users = client.users.find_all
#         expect(users).to_not be_empty
#         expect(users.first).to be_kind_of(Promisepay::Client::User)
#       end
#     end
#   end

#   describe 'find' do
#     context 'an existing user', vcr: { cassette_name: 'users_single' } do
#       it 'gives back a single user' do
#         user = client.users.find(1)
#         expect(user).to be_a(Promisepay::Client::User)
#       end
#     end

#     context 'an unkown user' do
#       it 'has to be implemented'
#     end
#   end
# end
