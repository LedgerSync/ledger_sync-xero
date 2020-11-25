# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Xero
    class Operation
      module Update
        module InstanceMethods
          private

          def ledger_resource_path
            if ledger_id_in_path?
              "#{ledger_resource_type_for_path}/#{resource.ledger_id}"
            else
              ledger_resource_type_for_path
            end
          end

          def operate
            response_to_operation_result(
              response: client.send(
                request_method,
                path: ledger_resource_path,
                payload: request_body
              )
            )
          end

          def request_body
            if request_body_as_array?
              {
                client.ledger_resource_type_for_path => [
                  serializer.serialize(resource: resource)
                ]
              }
            else
              serializer.serialize(resource: resource)
            end
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
