# frozen_string_literal: true

core_qa_support :ledger_helpers
qa_support :xero_shared_examples

module QA
  module XeroHelpers
    include LedgerSync::Test::QA::LedgerHelpers

    def client_class
      LedgerSync::Xero::Client
    end

    def xero_client
      @xero_client ||= client_class.new_from_env
    end
  end
end

RSpec.configure do |config|
  config.include QA::XeroHelpers, qa: true
end
