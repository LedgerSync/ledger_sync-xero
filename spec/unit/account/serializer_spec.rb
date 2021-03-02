# frozen_string_literal: true

require 'spec_helper'

module LedgerSync
  module Xero
    class Account
      RSpec.describe Serializer, unit: true do
        let(:serializer) { described_class.new }
        let(:account) do
          LedgerSync::Xero::Account.new(
            Status: 'active',
            TaxType: 'input',
            BankAccountNumber: 'test',
            BankAccountType: 'bank',
            Code: 'code',
            CurrencyCode: 'USD',
            Name: 'Name',
            Type: 'bank'
          )
        end

        it 'should not serialize any other key except status' do
          expect(serializer.serialize(resource: account)).to eq({
                                                                  'AccountID' => nil,
                                                                  'BankAccountNumber' => 'test',
                                                                  'Code' => 'code',
                                                                  'CurrencyCode' => 'USD',
                                                                  'Name' => 'Name',
                                                                  'Status' => nil,
                                                                  'Type' => 'BANK',
                                                                  'BankAccountType' => 'BANK'
                                                                })
        end
      end
    end
  end
end
