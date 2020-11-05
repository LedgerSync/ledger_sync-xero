# frozen_string_literal: true

require "spec_helper"

RSpec.describe LedgerSync::Xero::OAuthClient do
  subject do
    described_class.new client_secret: "secret", client_id: "client_id"
  end

  describe "Class Properties" do
    it { expect(described_class::AUTHORIZE_URL).to_not be_nil }
    it { expect(described_class::RESPONSE_TYPE).to_not be_nil }
    it { expect(described_class::SITE_URL).to_not be_nil }
    it { expect(described_class::TOKEN_URL).to_not be_nil }
    it { expect(described_class::SCOPE).to_not be_nil }
  end

  describe "#authorization_url" do
    it { expect(subject).to respond_to(:authorization_url) }
  end

  describe ".auth_code" do
    it {expect(subject).to respond_to(:auth_code)}
  end
end

