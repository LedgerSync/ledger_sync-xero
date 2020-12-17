# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Xero::Account::Operations::UpdateStatus, unit: true do
  describe '.inferred_resource_class' do
    it { expect(described_class.inferred_resource_class).to eq(LedgerSync::Xero::Account) }
  end

  describe '.request_body_as_array?' do
    it { expect(described_class.request_body_as_array?).to be_falsey }
  end

  describe '.ledger_id_in_path?' do
    it { expect(described_class.ledger_id_in_path?).to be_truthy }
  end

  describe '.ledger_resource_path' do
    it { expect(described_class.ledger_resource_path(ledger_id: 'account_id')).to eq('Accounts/account_id') }
  end

  describe '.request_method' do
    it { expect(described_class.request_method).to eq(:post) }
  end

  describe '.request_body' do
    let(:body) { { 'asdf' => 'blah' } }
    it { expect(described_class.request_body(body: body)).to eq(body) }
  end

  describe '.response_body_as_array?' do
    it { expect(described_class.response_body_as_array?).to be_truthy }
  end
end
