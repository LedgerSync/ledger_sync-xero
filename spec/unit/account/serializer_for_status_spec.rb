# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Xero::Account::StatusSerializer, unit: true do
  let(:serializer) {described_class.new}

  it "should not serialize any other key except status" do
    account = LedgerSync::Xero::Account.new Status: 'active'
    expect(described_class.new.serialize(resource: account).keys).to include "Status", "AccountID"

  end
end