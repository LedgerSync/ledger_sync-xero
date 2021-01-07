# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Xero::Account::Serializer, unit: true do
  let(:serializer) { described_class.new }

  it "should not serialize any other key except status" do
    account = LedgerSync::Xero::Account.new Status: 'active', TaxType: "input"
    expect(serializer.serialize(resource: account)).to eq({ "AccountID" => nil, "Status" => "ACTIVE" })
  end
end