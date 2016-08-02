require 'spec_helper'

describe Promisepay::DirectDebitAuthority do
  let(:client) { Promisepay::Client.new }

  describe 'delete' do
    let!(:dda) { PromisepayFactory.create_direct_debit_authority }
    it 'deletes the direct debit authority', vcr: { cassette_name: 'direct_debit_authority_delete', allow_playback_repeats: false } do
      expect { client.direct_debit_authorities.find(dda.id) }.not_to raise_error
      expect(dda.delete).to be(true)
      expect { client.direct_debit_authorities.find(dda.id) }.to raise_error(Promisepay::UnprocessableEntity)
    end
  end
end
