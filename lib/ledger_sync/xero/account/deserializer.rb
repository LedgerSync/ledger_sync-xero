# frozen_string_literal: true

require_relative '../type/tax_type'

module LedgerSync
  module Xero
    class Account
      class Deserializer < Xero::Deserializer
        attribute :ledger_id,
                  hash_attribute: 'AccountID'
        attribute :Code
        attribute :Name
        attribute :BankAccountNumber
        attribute :Description
        attribute :CurrencyCode

        mapping :Type, hash: Account::ACCOUNT_TYPES.invert
        mapping :Status, hash: Account::STATUS_CODES.invert
        mapping :BankAccountType, hash: Account::BANK_ACCOUNT_TYPES.invert
        mapping :TaxType, hash: Xero::Type::TaxType::TAX_TYPE.invert
        mapping :Class, hash: Account::CLASS_TYPES.invert
      end
    end
  end
end
