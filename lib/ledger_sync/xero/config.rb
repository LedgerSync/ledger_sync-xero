# frozen_string_literal: true

LedgerSync.register_ledger(:xero, { root_path: 'ledger_sync/xero' }) do |config|
  config.name = 'Xero'
end
