# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Xero do
  it 'has a version number' do
    expect(LedgerSync::Xero::VERSION).not_to be nil
  end
end