# frozen_string_literal: true

require 'spec_helper'

support :xero_helpers

RSpec.describe LedgerSync::Xero::OAuthClient do
  include XeroHelpers

  let(:client_id) { 'client_id' }
  let(:client_secret) { 'client_secret' }
  let(:redirect_uri) { 'https://www.example.com/?code=123&state=foo' }
  let(:token_code) { 'token_code' }
  let(:initialized_client) { described_class.new client_secret: client_secret, client_id: client_id }

  subject { initialized_client }

  describe 'Class Properties' do
    it { expect(described_class::AUTHORIZE_URL).to_not be_nil }
    it { expect(described_class::RESPONSE_TYPE).to_not be_nil }
    it { expect(described_class::SITE_URL).to_not be_nil }
    it { expect(described_class::TOKEN_URL).to_not be_nil }
    it { expect(described_class::SCOPE).to_not be_nil }
  end

  describe '#authorization_url' do
    subject { initialized_client.authorization_url(redirect_uri: redirect_uri) }

    it do
      allow(SecureRandom).to receive(:hex).and_return('asdfghjkl')
      url = 'https://login.xero.com/identity/connect/authorize?client_id=client_id&redirect_uri=https%3A%2F%2F' \
            'www.example.com%2F%3Fcode%3D123%26state%3Dfoo&response_type=code&scope=offline_access+openid+profile' \
            '+email+accounting.transactions+accounting.contacts+accounting.settings&state=asdfghjkl'
      expect(subject).to eq(url)
    end
  end

  describe '.auth_code' do
    it { expect(subject.auth_code).to be_a(OAuth2::Strategy::AuthCode) }
  end

  describe '.client' do
    it { expect(subject.client).to be_a(OAuth2::Client) }
  end

  describe '#get_token' do
    subject { initialized_client.get_token(code: 'token_code', redirect_uri: 'redirect_uri') }

    it do
      allow(initialized_client.auth_code).to receive(:get_token).and_return(:new_token)
      expect(subject).to eq(:new_token)
    end
  end

  describe '.new_from_env' do
    subject { described_class.new_from_env }
    it do
      ClimateControl.modify XERO_CLIENT_ID: 'client_id', XERO_CLIENT_SECRET: 'client_secret' do
        expect(subject).to be_a(described_class)
        expect(subject.client_id).to eq('client_id')
        expect(subject.client_secret).to eq('client_secret')
      end
    end
  end
end
