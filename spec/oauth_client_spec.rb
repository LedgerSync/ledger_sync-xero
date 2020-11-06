# frozen_string_literal: true

require 'spec_helper'

support :xero_helpers

RSpec.describe LedgerSync::Xero::OAuthClient do
  include XeroHelpers

  let(:client_id) { 'client_id' }
  let(:client_secret) { 'client_secret' }
  let(:redirect_uri) { 'redirect_uri' }
  let(:token_code) { 'token_code' }

  subject do
    described_class.new client_secret: client_secret, client_id: client_id
  end

  describe 'Class Properties' do
    it { expect(described_class::AUTHORIZE_URL).to_not be_nil }
    it { expect(described_class::RESPONSE_TYPE).to_not be_nil }
    it { expect(described_class::SITE_URL).to_not be_nil }
    it { expect(described_class::TOKEN_URL).to_not be_nil }
    it { expect(described_class::SCOPE).to_not be_nil }
  end

  describe '#authorization_url' do
    it { expect(subject).to respond_to(:authorization_url) }
  end

  describe '.auth_code' do
    it { expect(subject.auth_code).to be_a(OAuth2::Strategy::AuthCode) }
  end

  describe '.client' do
    it { expect(subject.client).to be_a(OAuth2::Client) }
  end

  describe '#get_token' do
    it do
      expect(subject).to respond_to(:get_token)
    end
  end

  describe '#new_from_env' do
    it do
      expect(described_class).to respond_to(:new_from_env)
    end
  end
end
