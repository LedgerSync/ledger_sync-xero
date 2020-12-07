# frozen_string_literal: true

module LedgerSync
  module Xero
    class Account
      module Operations
        class Create
          include Xero::Operation::CreatePut

          class Contract < LedgerSync::Ledgers::Contract
            params do
              required(:ledger_id).value(:nil)
              required(:external_id).filled(:string)
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
          end

          def self.request_body_as_array?
            false
          end

          def self.response_body_as_array?
            true
          end
        end
      end
    end
  end
end
