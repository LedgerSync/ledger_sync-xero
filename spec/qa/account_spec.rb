# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Xero::Account, qa: true do
  let(:client) { xero_client }
  let(:attribute_updates) do
    {
      Name: "QA Update #{test_run_id}"
    }
  end

  let(:resource) do

    LedgerSync::Xero::Account.new(
      Name: "Test Account Name #{test_run_id} #{FactoryBot.rand_id}",
      Code: rand(1000).to_s,
      Type: 'equity',
      BankAccountNumber: FactoryBot.rand_id,
      Status: 'active',
      Description: "Test Account Description #{test_run_id}",
      BankAccountType: 'paypal',
      CurrencyCode: 'USD',
      TaxType: 'input',
      Class: 'asset'
    )
  end

  it_behaves_like 'a full xero resource'
end

