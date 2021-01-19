# frozen_string_literal: true

require_relative '../operation/update'

module LedgerSync
  module Xero
    class Operation
      class UpdatePost
        include Xero::Operation::Update

        def self.ledger_id_in_path?
          true
        end

        def self.request_body_as_array?
          false
        end

        def self.request_method
          :post
        end
      end
    end
  end
end
