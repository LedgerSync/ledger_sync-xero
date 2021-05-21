# frozen_string_literal: true

require 'spec_helper'

module LedgerSync
  module Xero
    RSpec.describe Contact, qa: true do
      let(:client) { xero_client }
      let(:attribute_updates) do
        {
          Name: "QA UPDATE #{test_run_id}"
        }
      end
      # let(:record) { :contact }
      let(:resource) do
        Contact.new(
          EmailAddress: "#{test_run_id}@example.com",
          Name: "Test Contact #{test_run_id}"
        )
      end

      it_behaves_like 'a full xero resource'
    end
  end
end
