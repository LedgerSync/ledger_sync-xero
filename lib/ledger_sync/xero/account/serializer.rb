# frozen_string_literal: true

module LedgerSync
  module Xero
    class Account
      class Serializer < Xero::Serializer
        attribute 'AccountID',
                  resource_attribute: :ledger_id
        attribute :Code
        attribute :Name
        attribute :BankAccountNumber
        # attribute :Description
        attribute :CurrencyCode

        attribute :Status do
          nil
        end

        mapping :Type, hash: Account::TYPES

        # mapping :Status, hash: Account::STATUS_CODES

        mapping :BankAccountType, hash: Account::BANK_ACCOUNT_TYPES
        # mapping :TaxType, hash: Account::TAX_TYPE
        # mapping :Class, hash: Account::CLASS_TYPES
      end
    end
  end
end
