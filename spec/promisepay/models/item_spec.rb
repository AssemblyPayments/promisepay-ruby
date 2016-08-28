require 'spec_helper'

describe Promisepay::Item do
  let(:client) { Promisepay::Client.new }
  let(:item) { PromisepayFactory.create_item }

  describe 'update' do
    context 'with valid attributes', vcr: { cassette_name: 'items_updated' } do
      let(:valid_attributes) { { name: 'updatedName' } }
      it 'correctly updates the item' do
        original_name = item.name
        item.update(valid_attributes)
        expect(item.name).to_not eql(original_name)
        expect(item.name).to eql('updatedName')
      end
    end

    context 'with invalid attributes', vcr: { cassette_name: 'items_updated_error' } do
      let(:invalid_attributes) { { amount: 1 } }

      it 'raises an error' do
        expect { item.update(invalid_attributes) }.to raise_error(Promisepay::UnprocessableEntity)
      end
    end
  end

  describe 'status', vcr: { cassette_name: 'items_status' } do
    it 'returns the item status' do
      status = item.status
      expect(status).to be_a(Hash)
      expect(status).to have_key('status')
      expect(status).to have_key('state')
    end
  end

  describe 'buyer', vcr: { cassette_name: 'items_buyer' } do
    it 'returns a user' do
      buyer = item.buyer
      expect(buyer).to be_a(Promisepay::User)
    end
  end

  describe 'seller', vcr: { cassette_name: 'items_seller' } do
    it 'returns a user' do
      seller = item.seller
      expect(seller).to be_a(Promisepay::User)
    end
  end

  describe 'fees' do
    context 'when no fees are available', vcr: { cassette_name: 'items_fees_empty' } do
      it 'gives back en empty array' do
        fees = item.fees
        expect(fees).to be_empty
      end
    end

    context 'when fees are available', vcr: { cassette_name: 'items_fees' } do
      let(:fee) { PromisepayFactory.create_fee }
      it 'gives back an array of fees'
      # it 'gives back an array of fees' do
      #   fees = item.fees
      #   expect(fees).to_not be_empty
      #   expect(fees.first).to be_a(Promisepay::Fee)
      # end
    end
  end

  describe 'transactions' do
    context 'when no transactions are available', vcr: { cassette_name: 'items_transactions_empty' } do
      it 'gives back en empty array' do
        transactions = item.transactions
        expect(transactions).to be_empty
      end
    end

    context 'when transactions are available', vcr: { cassette_name: 'items_transactions' } do
      it 'gives back an array of transactions'
      # it 'gives back an array of transactions' do
      #   transactions = item.transactions
      #   expect(transactions).to_not be_empty
      #   expect(transactions.first).to be_a(Promisepay::Transaction)
      # end
    end
  end

  describe 'batch_transactions' do
    context 'when no batch_transactions are available', vcr: { cassette_name: 'items_batch_transactions_empty' } do
      it 'gives back en empty array' do
        batch_transactions = item.batch_transactions
        expect(batch_transactions).to be_empty
      end
    end

    context 'when batch_transactions are available', vcr: { cassette_name: 'items_batch_transactions' } do
      let(:seller) { PromisepayFactory.create_user}
      let(:buyer) { PromisepayFactory.create_user}
      let(:item) { PromisepayFactory.create_item({}, seller, buyer)}
      let(:account) { PromisepayFactory.create_bank_account({}, buyer)}
      before do
        client.direct_debit_authorities.create(account_id: account.id, amount: 100_000)
        item.request_payment
        item.make_payment(account_id: account.id)
      end
      it 'gives back an array of batch_transactions' do
        batch_transactions = item.batch_transactions
        expect(batch_transactions).to_not be_empty
        expect(batch_transactions.first).to be_a(Promisepay::BatchTransaction)
      end
    end
  end

  describe 'wire_details', vcr: { cassette_name: 'items_wire_details' } do
    it 'returns a Hash' do
      details = item.wire_details
      expect(details).to be_a(Hash)
      expect(details).to have_key('reference')
    end
  end

  describe 'bpay_details', vcr: { cassette_name: 'items_bpay_details' } do
    it 'returns a Hash' do
      details = item.bpay_details
      expect(details).to be_a(Hash)
      expect(details).to have_key('reference')
    end
  end

  describe 'action methods' do
    let(:buyer) { item.buyer }
    let(:card_account) { PromisepayFactory.create_card_account({}, buyer) }

    describe 'make_payment' do
      it 'makes the payment', vcr: { cassette_name: 'items_make_payment' } do
        expect(item.state).to eq('pending')
        expect(
          item.make_payment(user_id: buyer.id, account_id: card_account.id)
        ).to be(true)
        expect(%w(payment_held payment_processing payment_deposited)).to include(item.state)
      end
    end

    describe 'request_payment', vcr: { cassette_name: 'items_request_payment' } do
      it 'requests the payment' do
        expect(item.state).to eq('pending')
        expect(item.request_payment).to be(true)
        expect(item.state).to eq('payment_required')
      end
    end

    describe 'release_payment', vcr: { cassette_name: 'items_release_payment' } do
      before { item.make_payment(user_id: buyer.id, account_id: card_account.id) }
      it 'requests release of funds held in escrow' do
        expect(item.state).to eq('payment_deposited')
        expect(item.release_payment).to be(true)
        expect(item.state).to eq('completed')
      end
    end

    describe 'request_release', vcr: { cassette_name: 'items_request_release' } do
      before { item.make_payment(user_id: buyer.id, account_id: card_account.id) }
      it 'requests release of funds held in escrow' do
        expect(item.state).to eq('payment_deposited')
        expect(item.request_release).to be(true)
        expect(item.state).to eq('work_completed')
      end
    end

    describe 'acknowledge_wire' do
      it 'acknowledges the wire', vcr: { cassette_name: 'items_acknowledge_wire' } do
        expect(item.state).to eq('pending')
        expect(item.acknowledge_wire).to be(true)
        expect(item.state).to eq('wire_pending')
      end
    end

    describe 'acknowledge_paypal' do
      it 'is not documented'
    end

    describe 'revert_wire' do
      before { item.acknowledge_wire }
      it 'reverts the wire', vcr: { cassette_name: 'items_revert_wire' } do
        expect(item.state).to eq('wire_pending')
        expect(item.revert_wire).to be(true)
        expect(item.state).to eq('pending')
      end
    end

    describe 'request_refund', vcr: { cassette_name: 'items_request_refund' } do
      before { item.make_payment(user_id: buyer.id, account_id: card_account.id) }
      it 'requests a refund' do
        expect(item.state).to eq('payment_deposited')
        expect(item.request_refund(refund_amount: 500, refund_message: 'because')).to be(true)
        expect(item.state).to eq('refund_flagged')
      end
    end

    describe 'decline_refund', vcr: { cassette_name: 'items_decline_refund' } do
      before do
        item.make_payment(user_id: buyer.id, account_id: card_account.id)
        item.request_refund(refund_amount: 500, refund_message: 'because')
      end
      it 'declines a refund' do
        expect(item.state).to eq('refund_flagged')
        expect(item.decline_refund).to be(true)
        expect(item.state).to eq('payment_deposited')
      end
    end

    describe 'raise_dispute', vcr: { cassette_name: 'items_raise_dispute' } do
      before { item.make_payment(user_id: buyer.id, account_id: card_account.id) }
      it 'raises a dispute' do
        expect(item.state).to eq('payment_deposited')
        expect(item.raise_dispute(user_id: buyer.id)).to be(true)
        expect(item.state).to eq('problem_flagged')
      end
    end

    describe 'request_resolve_dispute', vcr: { cassette_name: 'items_request_resolve_dispute' } do
      before do
        item.make_payment(user_id: buyer.id, account_id: card_account.id)
        item.raise_dispute(user_id: buyer.id)
      end
      it 'requests a resolution for the dispute' do
        expect(item.state).to eq('problem_flagged')
        expect(item.request_resolve_dispute).to be(true)
        expect(item.state).to eq('problem_resolve_requested')
      end
    end

    describe 'resolve_dispute', vcr: { cassette_name: 'items_resolve_dispute' } do
      before do
        item.make_payment(user_id: buyer.id, account_id: card_account.id)
        item.raise_dispute(user_id: buyer.id)
        item.request_resolve_dispute
      end
      it 'requests a resolution for the dispute' do
        expect(item.state).to eq('problem_resolve_requested')
        expect(item.resolve_dispute).to be(true)
        expect(item.state).to eq('payment_deposited')
      end
    end

    describe 'escalate_dispute', vcr: { cassette_name: 'items_escalate_dispute' } do
      before do
        item.make_payment(user_id: buyer.id, account_id: card_account.id)
        item.raise_dispute(user_id: buyer.id)
      end
      it 'escaltates a dispute' do
        expect(item.state).to eq('problem_flagged')
        expect(item.escalate_dispute).to be(true)
        expect(item.state).to eq('problem_escalated')
      end
    end

    describe 'refund', vcr: { cassette_name: 'items_refund' } do
      before { item.make_payment(user_id: buyer.id, account_id: card_account.id) }
      it 'requests a refund' do
        expect(item.state).to eq('payment_deposited')
        expect(item.refund(refund_amount: 500, refund_message: 'because')).to be(true)
        expect(item.state).to eq('refunded')
      end
    end

    describe 'cancel' do
      it 'cancels the item', vcr: { cassette_name: 'items_cancel' } do
        expect(item.state).to eq('pending')
        expect(item.cancel).to be(true)
        expect(item.state).to eq('cancelled')
      end
    end

    describe 'send_tax_invoice', vcr: { cassette_name: 'items_send_tax_invoice' } do
      before { item.make_payment(user_id: buyer.id, account_id: card_account.id) }
      it 'returns true' do
        expect(item.send_tax_invoice).to be(true)
      end
    end

    describe 'request_tax_invoice', vcr: { cassette_name: 'items_request_tax_invoice' } do
      before { item.make_payment(user_id: buyer.id, account_id: card_account.id) }
      it 'returns true' do
        expect(item.request_tax_invoice).to be(true)
      end
    end
  end
end
