# frozen_string_literal: true

module LedgerSync
  module Xero
    class Account
      module Operations
        class UpdateStatus < Xero::Operation::UpdatePost
          class Contract < LedgerSync::Ledgers::Contract
            params do
              required(:ledger_id).filled(:string)
              required(:external_id).filled(:string)
              required(:Status).filled(:string)
            end
          end

          def serializer_class
            @serializer_class ||= StatusSerializer
          end

          def serializer
            @serializer ||= serializer_class.new
          end
        end
      end
    end
  end
end
