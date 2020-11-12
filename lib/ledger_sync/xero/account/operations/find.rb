# frozen_string_literal: true

module LedgerSync
  module Xero
    class Contact
      module Operations
        class Find < Xero::Operation::Find
          class Account < LedgerSync::Ledgers::Contract
            params do
              optional(:external_id).filled(:string)
              required(:ledger_id).filled(:nil)
              optional(:Code).maybe(:string)
              optional(:Name).maybe(:string)
              optional(:BankAccountNumber).maybe(:string)
              optional(:Description).maybe(:string)
              optional(:CurrencyCode).maybe(:string)
              optional(:Type).maybe(:string)
              optional(:Status).maybe(:string)
              optional(:BankAccountTypes).maybe(:string)
              optional(:TaxType).maybe(:string)
              optional(:Class).maybe(:string)
            end
          end
        end
      end
    end
  end
end
