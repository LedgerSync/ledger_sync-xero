# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Xero
    class Operation
      module Find
        module InstanceMethods
          private

          def operate
            response_to_operation_result(
              response: client.find(
                path: ledger_resource_path
              )
            )
          end

          def request_body
            self.class.request_body(body: serializer.serialize(resource: resource))
          end
        end

        module ClassMethods
          def request_body_as_array?
            nil
          end
        end

        def self.included(base)
          base.include Xero::Operation::Mixin
          base.include InstanceMethods
          base.extend ClassMethods
        end
      end
    end
  end
end
