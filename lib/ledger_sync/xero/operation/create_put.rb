# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Xero
    class Operation
      module CreatePut
        def self.included(base)
          base.include Xero::Operation::Create
          base.extend ClassMethods
        end

        module ClassMethods
          def request_method
            :put
          end
        end
      end
    end
  end
end
