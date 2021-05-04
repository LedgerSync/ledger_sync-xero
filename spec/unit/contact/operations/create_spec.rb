# frozen_string_literal: true

require 'spec_helper'

module LedgerSync
  module Xero
    class Contact
      module Operations
        RSpec.describe Create, unit: true do
          describe '.inferred_resource_class' do
            it { expect(described_class.inferred_resource_class).to eq(Contact) }
          end

          describe '.request_body_as_array?' do
            it { expect(described_class.request_body_as_array?).to be_truthy }
          end

          describe '.ledger_id_in_path?' do
            it { expect(described_class.ledger_id_in_path?).to be_falsey }
          end

          describe '.ledger_resource_path' do
            it { expect(described_class.ledger_resource_path(ledger_id: 'contact_id')).to eq('Contacts') }
          end

          describe '.request_method' do
            it { expect(described_class.request_method).to eq(:post) }
          end

          describe '.request_body' do
            let(:body) { { 'id' => 'contact_id' } }
            it { expect(described_class.request_body(body: body)).to eq({ 'Contacts' => [body] }) }
          end
        end
      end
    end
  end
end
