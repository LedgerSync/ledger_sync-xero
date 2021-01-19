# frozen_string_literal: true

module LedgerSync
  module Xero
    class Account
      class SerializerForStatus < Xero::Serializer
        attribute 'AccountID',
                  resource_attribute: :ledger_id
        mapping :Status, hash: Account::STATUS_CODES
      end
    end
  end
end
