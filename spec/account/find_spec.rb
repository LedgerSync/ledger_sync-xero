# frozen_string_literal: true

require 'spec_helper'

support :xero_shared_examples

RSpec.describe LedgerSync::Xero::Account::Operations::Find, operation: true do
  it_behaves_like 'a xero operation'
end
