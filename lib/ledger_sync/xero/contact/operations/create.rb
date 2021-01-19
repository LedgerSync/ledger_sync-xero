# frozen_string_literal: true

module LedgerSync
  module Xero
    class Contact
      module Operations
        class Create
          include Xero::Operation::CreatePost

          class Contract < LedgerSync::Ledgers::Contract
            params do
              required(:external_id).filled(:string)
              required(:ledger_id).value(:nil)
              required(:Name).maybe(:string)
              required(:EmailAddress).maybe(:string)
            end
          end

          def self.request_body_as_array?
            true
          end
        end
      end
    end
  end
end
