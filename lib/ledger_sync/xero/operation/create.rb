# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Xero
    class Operation
      module Create
        module InstanceMethods
          private

          def operate
            response_to_operation_result(
              response: client.send(
                self.class.request_method,
                path: ledger_resource_path,
                payload: request_body
              )
            )
          end

          def request_body
            self.class.request_body(body: serializer.serialize(resource: resource))
          end
        end

        def self.included(base)
          base.include Xero::Operation::Mixin
          base.include InstanceMethods
        end
      end
    end
  end
end
