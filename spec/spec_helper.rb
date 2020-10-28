# frozen_string_literal: true

require 'ledger_sync/test/support'

LedgerSync::Test::Support.setup('ledger_sync/xero')

setup_client_qa_support(LedgerSync::Xero::Client)
