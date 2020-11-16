# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Xero
    class Operation
      class UpdatePut
        include Xero::Operation::Mixin

        private

        def operate
          operate_creator method: :put
        end
      end
    end
  end
end
