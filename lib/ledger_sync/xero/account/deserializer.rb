# frozen_string_literal: true

module LedgerSync
  module Xero
    class Contact
      class Serializer < Xero::Deserializer
        attribute :ledger_id,
                  resource_attribute: 'AccountID'
        attribute :Code
        attribute :Name
        attribute :Type
        attribute :BankAccountNumber
        attribute :Status
        attribute :Description
        attribute :BankAccountTypes
        attribute :CurrencyCode
        attribute :TaxType
        attribute :Class
      end
    end
  end
end
