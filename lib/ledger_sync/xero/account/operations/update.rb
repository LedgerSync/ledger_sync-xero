# frozen_string_literal: true

module LedgerSync
  module Xero
    class Contact
      module Operations
        class Update < Xero::Operation::UpdatePost
          class Account < LedgerSync::Ledgers::Contract
            params do
              required(:external_id).filled(:string)
              required(:ledger_id).filled(:nil)
              required(:Code).maybe(:string)
              required(:Name).maybe(:string)
              required(:BankAccountNumber).maybe(:string)
              required(:Description).maybe(:string)
              required(:CurrencyCode).maybe(:string)
              required(:Type).maybe(:string)
              required(:Status).maybe(:string)
              required(:BankAccountTypes).maybe(:string)
              required(:TaxType).maybe(:string)
              required(:Class).maybe(:string)
            end
          end
        end
      end
    end
  end
end