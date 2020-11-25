# frozen_string_literal: true

require_relative '../operation/update'

module LedgerSync
  module Xero
    class Operation
      class UpdatePut
        include Xero::Operation::Update

        def self.ledger_id_in_path?
          false
        end

        def self.request_body_as_array?
          true
        end

        def self.request_method
          :put
        end
      end
    end
  end
end
