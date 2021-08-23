# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/ledger_sync/xero/type/tax_type'

module LedgerSync
  module Xero
    module Type
      RSpec.describe TaxType, unit: true do
        let(:classWithTaxType) do
          Class.new(Xero::Resource)
          attribute :TaxType, type: Type::TaxType
        end

        it 'should not allow invalid values' do
          invalid_value = classWithTaxType.new TaxType: 'exempt_expenses'
        end
      end
    end
  end
end
