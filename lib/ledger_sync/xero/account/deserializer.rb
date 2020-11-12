# frozen_string_literal: true

module LedgerSync
  module Xero
    class Contact
      class Serializer < Xero::Deserializer
        attribute :ledger_id,
                  resource_attribute: 'AccountID'
        attribute :Code
        attribute :Name
        attribute :BankAccountNumber
        attribute :Description
        attribute :CurrencyCode
        mapping :Type, hash: Account::TYPES.invert
        mapping :Status, hash: Account::STATUS_CODES.invert
        mapping :BankAccountTypes, hash: Account::BANK_ACCOUNT_TYPES.invert
        mapping :TaxType, hash: Account::TAX_TYPE.invert
        mapping :Class, hash: Account::CLASS_TYPES.invert
      end
    end
  end
end
