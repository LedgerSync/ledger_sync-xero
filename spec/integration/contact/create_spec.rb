# frozen_string_literal: true

require 'spec_helper'

support :xero_shared_examples

RSpec.describe LedgerSync::Xero::Contact::Operations::Create, operation: true do
  it_behaves_like 'a xero operation'
end
