# frozen_string_literal: true

module LedgerSync
  module Xero
    class Contact < Xero::Resource
      attribute :Name, type: Type::String
      attribute :EmailAddress, type: Type::String
    end
  end
end
