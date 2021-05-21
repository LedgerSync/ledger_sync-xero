# frozen_string_literal: true

require 'spec_helper'

support :xero_shared_examples

module LedgerSync
  module Xero
    class Account
      module Operations
        RSpec.describe UpdateStatus, operation: true do
          let(:resource) { create(:xero_account, ledger_id: 'test', Status: 'archived') }
          it_behaves_like 'a xero operation'
        end
      end
    end
  end
end
