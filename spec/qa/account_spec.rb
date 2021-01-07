# frozen_string_literal: true

require 'spec_helper'

def new_account(test_run_id:)
  #  Credit Card or Paypal accounts not supported by Xero for now.
  LedgerSync::Xero::Account.new(
    Name: "Test Account Name #{test_run_id} #{FactoryBot.rand_id}",
    Code: rand(10_000).to_s,
    Type: 'expense',
    BankAccountNumber: FactoryBot.rand_id,
    CurrencyCode: 'USD'
  )
end

RSpec.describe LedgerSync::Xero::Account, qa: true do
  let(:client) { xero_client }
  let(:attribute_updates) do
    {
      Name: "QA Account Update #{test_run_id}"
    }
  end

  let(:resource) do
    new_account(test_run_id: test_run_id)
  end

  it_behaves_like 'a full xero resource'
end

# TODO: Need to Dry this somehow
RSpec.describe LedgerSync::Xero::Account, qa: true do
  let(:client) { xero_client }

  let(:attribute_updates) do
    {
      Status: 'archived'
    }
  end

  let(:resource) do
    new_account(test_run_id: test_run_id)
  end

  it do
    result = create_result_for(
      client: client,
      resource: resource
    ).raise_if_error

    expect(result).to be_success
    resource = result.resource

    # Ensure values are currently not the same as the updates
    attribute_updates.each do |k, v|
      expect(resource.send(k)).not_to eq(v)
    end

    resource.assign_attributes(attribute_updates)

    result = result_for(
      client: client,
      method: :update_status,
      resource: resource
    )

    expect(result).to be_success
    resource = result.resource

    # Ensure values are updated
    attribute_updates.each do |k, v|
      expect(resource.send(k)).to eq(v)
    end

    result = find_result_for(
      client: client,
      resource: resource.class.new(
        ledger_id: resource.ledger_id
      )
    ).raise_if_error

    expect(result).to be_success
    resource = result.resource

    # Ensure values are updated after raw find
    attribute_updates.each do |k, v|
      expect(resource.send(k)).to eq(v)
    end
  end
end
