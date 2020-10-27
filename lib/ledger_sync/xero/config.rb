# frozen_string_literal: true

require_relative 'client'

LedgerSync.register_ledger(:xero, base_module: LedgerSync::Xero, root_path: 'ledger_sync/xero') do |config|
  config.name = 'Xero'
end
