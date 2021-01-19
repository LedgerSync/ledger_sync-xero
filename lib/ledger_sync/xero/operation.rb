# frozen_string_literal: true

module LedgerSync
  module Xero
    class Operation
      module Mixin
        def self.included(base)
          base.include Ledgers::Operation::Mixin
          base.include InstanceMethods # To ensure these override parent methods
          base.extend ClassMethods # To ensure these override parent methods
        end

        module ClassMethods
          def ledger_id_in_path?
            false
          end

          def ledger_resource_path(ledger_id:)
            parts = [ledger_resource_type_for_path]
            parts << ledger_id if ledger_id_in_path? && ledger_id.present?
            File.join(*parts)
          end

          def ledger_resource_type_for_path
            Util::StringHelpers.camelcase(
              Client.ledger_resource_type_for(resource_class: inferred_resource_class)
            ).pluralize
          end

          def request_body(body:)
            if request_body_as_array?
              {
                ledger_resource_type_for_path => [body]
              }
            else
              body
            end
          end

          def response_body_as_array?
            true # Default
          end
        end

        module InstanceMethods
          def deserialized_resource(response:)
            deserializer.deserialize(
              hash: response,
              resource: resource
            )
          end

          def ledger_resource_path
            @ledger_resource_path ||= self.class.ledger_resource_path(ledger_id: resource.ledger_id)
          end

          def response_to_operation_result(response:)
            resource_body = if self.class.response_body_as_array?
                              response.body[self.class.ledger_resource_type_for_path]&.first
                            else
                              response.body
                            end

            if response.success?
              success(
                resource: deserialized_resource(
                  response: resource_body
                ),
                response: response
              )
            else
              failure
              # TODO: implement failure handler
            end
          end

          def perform
            super
          rescue LedgerSync::Error::OperationError, OAuth2::Error => e
            failure(e)
          ensure
            client.update_secrets_in_dotenv
          end
        end
      end
    end
  end
end
