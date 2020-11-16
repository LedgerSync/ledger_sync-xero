# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Xero
    class Operation
      class CreatePost
        include Xero::Operation::Mixin

        private

        def operate
          operate_creator
        end
      end
    end
  end
end
