# frozen_string_literal: true

module LedgerSync
  module Xero
    class Contact
      module Operations
        class Find
          include Xero::Operation::Find

          class Contract < LedgerSync::Ledgers::Contract
            params do
              optional(:external_id).filled(:string)
              required(:ledger_id).filled(:string)
              optional(:Name).maybe(:string)
              optional(:EmailAddress).maybe(:string)
            end
          end

          def self.ledger_id_in_path?
            true
          end
        end
      end
    end
  end
end
