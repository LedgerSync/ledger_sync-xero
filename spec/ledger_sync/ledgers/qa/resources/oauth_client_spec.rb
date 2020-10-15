require_relative '../qa_helper'

RSpec.describe LedgerSync::Ledgers::Xero::Client qa: true do

  it 'should create a new refresh token #refresh!' do
    xero_oauth_client = LedgerSync::Ledgers::Xero::Client.new_from_env
    previous_refresh_token = xero_oauth_client.refresh_token
    new_refresh_token = xero_oauth_client.refresh!.refresh_token

    expect(new_refresh_token.length).to be > 5
    expect(previous_refresh_token).not_to be new_refresh_token
  end
end