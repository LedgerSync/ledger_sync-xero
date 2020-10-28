# frozen_string_literal: true

require 'ledger_sync'

module LedgerSync
  module Xero
    def self.root
      File.expand_path('../..', __dir__)
    end
  end
end

require_relative 'xero/config'
