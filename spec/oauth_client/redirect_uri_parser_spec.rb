# frozen_string_literal: true

require 'spec_helper'

support :xero_helpers

RSpec.describe LedgerSync::Xero::OAuthClient::RedirectURIParser do
  include XeroHelpers

  let(:uri) { 'https://www.example.com?code=asdf&realmId=test_realm' }

  subject do
    described_class.new uri: uri
  end

  describe '#code' do
    it { expect(subject.code).to eq('asdf') }
  end

  describe '.parsed_uri' do
    it { expect(subject.parsed_uri).to be_a(URI::HTTPS) }
  end

  describe '.query' do
    it { expect(subject.query).to eq({ 'code' => ['asdf'], 'realmId' => ['test_realm'] }) }
  end

  describe '#realm_id' do
    it { expect(subject.realm_id).to eq('test_realm') }
  end

  describe '#redirect_uri' do
    it { expect(subject.redirect_uri).to eq('https://www.example.com') }
  end
end
