# frozen_string_literal: true

module LedgerSync
  module Xero
    class Account
      module Operations
        class Update < Xero::Operation::UpdatePost
          class Contract < LedgerSync::Ledgers::Contract
            params do
              required(:external_id).filled(:string)
              required(:ledger_id).filled(:string)
              required(:Code).maybe(:string)
              required(:Name).maybe(:string)
              required(:BankAccountNumber).maybe(:string)
              # required(:Description).maybe(:string)
              required(:CurrencyCode).maybe(:string)
              required(:Type).maybe(:string)
              required(:Status).maybe(:string)
              required(:BankAccountType).maybe(:string)
              # required(:TaxType).maybe(:string)
              # required(:Class).maybe(:string)
            end

            rule(:Status) do
              key.failure('Cannot update Status and Account Details in the same call') if ([:Status] & values.keys).any?
            end
          end
        end
      end
    end
  end
end
