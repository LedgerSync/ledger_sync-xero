# frozen_string_literal: true

core_support :operation_shared_examples
support :xero_helpers

RSpec.shared_examples 'a xero operation' do
  include XeroHelpers

  let(:resource) { FactoryBot.create("#{client.class.config.root_key}_#{record}") } unless method_defined?(:resource)
  let(:client) { xero_client } unless method_defined?(:client)
  unless method_defined?(:record)
    let(:record) do
      described_class.inferred_resource_class.resource_type.to_s
    end
  end

  # let(:request_params) { described_class.new(client: client, resource: nil).request_params }

  before do
    case described_class.operation_method
    when :create
      resource.ledger_id = nil
    when :delete
      resource.ledger_id = xero_records.send(record).id
    when :find
      resource.ledger_id = xero_records.send(record).id
    when :update
      resource.ledger_id = xero_records.send(record).id
    end
  end

  it_behaves_like 'a valid operation'

  context do
    before do
      case described_class.operation_method
      when :create
        stub_create_for_record
      when :delete
        resource.ledger_id = xero_records.send(record).id
        stub_delete_for_record
      when :find
        resource.ledger_id = xero_records.send(record).id
        stub_find_for_record
      when :update
        resource.ledger_id = xero_records.send(record).id
        stub_update_for_record(
          ledger_id_in_path: described_class.ledger_id_in_path?,
          request_body_as_array: described_class.request_body_as_array?,
          request_method: described_class.request_method
        )
      end
    end

    it_behaves_like 'a successful operation'
  end
end
