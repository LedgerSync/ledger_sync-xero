# frozen_string_literal: true

# Define globally so it's only evaluated once.

module LedgerSync
  module Test
    class XeroRecord < Record
      def id
        hash.fetch(xero_record_type.pluralize, []).first.fetch("#{xero_record_type}ID", nil)
      end

      def xero_record_type
        Util::StringHelpers.camelcase(record)
      end
    end
  end
end

XERO_RECORD_COLLECTION = LedgerSync::Test::RecordCollection.new(
  dir: File.join(LedgerSync::Xero.root, 'spec/support/records'),
  record_class: LedgerSync::Test::XeroRecord
)

module XeroHelpers # rubocop:disable Metrics/ModuleLength
  def authorized_headers(override = {}, write: false)
    if write
      override = override.merge(
        'Content-Type' => 'application/json'
      )
    end

    {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' =>
        /
        Bearer
        \s
        .+
        /x,
      'User-Agent' => /.*/
    }.merge(override)
  end

  def api_record_url(args = {})
    _record = args.fetch(:record)
    id      = args.fetch(:id, nil)
    params  = args.fetch(:params, {})

    resource_endpoint = LedgerSync::Util::StringHelpers.camelcase(
      xero_client.class.ledger_resource_type_for(resource_class: resource.class).pluralize
    )
    ret = "https://api.xero.com/api.xro/2.0/#{resource_endpoint}"

    if id.present?
      ret += '/' unless ret.end_with?('/')
      ret += id.to_s
    end

    if params.present?
      uri = URI(ret)
      uri.query = params.to_query
      ret = uri.to_s
    end

    ret
  end

  def response_headers(overrides = {})
    {
      'Content-Type' => 'application/json'
    }.merge(overrides)
  end

  def xero_client
    LedgerSync.ledgers.xero.new_from_env
  end

  def xero_env?
    @xero_env ||= ENV.key?('USE_DOTENV_ADAPTOR_SECRETS')
  end

  def xero_records
    @xero_records ||= XERO_RECORD_COLLECTION
  end

  def xero_resource_type
    record.to_s.gsub(/^xero_/, '')
  end

  def stub_get_token(args = {})
    response_body_overrides = args.fetch(:response_body_overrides, {})

    stub_request(:post, 'https://identity.xero.com/connect/token')
      .with(
        body: {
          'client_id' => 'client_id',
          'client_secret' => 'client_secret',
          'code' => 'token_code',
          'grant_type' => 'authorization_code',
          'redirect_uri' => 'redirect_uri'
        },
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      ).to_return(
        status: 200,
        body: {
          'id_token' => 'new_id_token',
          'access_token' => 'new_access_token',
          'expires_in' => 1800,
          'token_type' => 'Bearer',
          'refresh_token' => 'new_refresh_token',
          'scope' => 'openid profile email accounting.transactions accounting.contacts offline_access'
        }.with_indifferent_access.merge(response_body_overrides).to_json,
        headers: response_headers
      )
  end

  def stub_client_refresh
    stub_request(:post, 'https://identity.xero.com/connect/token')
      .with(
        body: {
          'client_id' => 'client_id',
          'client_secret' => 'client_secret',
          'grant_type' => 'refresh_token',
          'refresh_token' => 'refresh_token'
        },
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'token_type' => 'bearer',
                'expires_in' => 3600,
                'refresh_token' => 'NEW_REFRESH_TOKEN',
                'x_refresh_token_expires_in' => 1_569_480_516,
                'access_token' => 'NEW_ACCESS_TOKEN' }.to_json,
        headers: response_headers
      )
  end

  def stub_create_for_record(**params)
    send("stub_#{xero_resource_type}_create", params.compact)
  end

  def stub_create_request(body:, url:, method: :post)
    stub_request(method, url)
      .with(
        headers: authorized_headers(write: true)
      )
      .to_return(
        status: 200,
        body: body.to_json
      )
  end

  def stub_delete_for_record
    send("stub_#{xero_resource_type}_delete")
  end

  def stub_delete_request(url:)
    stub_request(:delete, url)
      .with(
        headers: authorized_headers
      )
      .to_return(
        status: 204,
        body: '',
        headers: {}
      )
  end

  def stub_find_for_record(params: {})
    send("stub_#{xero_resource_type}_find", params)
  end

  def stub_find_request(response_body:, url:)
    stub_request(:get, url)
      .to_return(
        status: 200,
        body: (response_body.is_a?(Hash) ? response_body.to_json : response_body)
      )
  end

  def stub_search_for_record
    send("stub_#{xero_resource_type}_search")
  end

  def stub_update_for_record(**params)
    send("stub_#{xero_resource_type}_update", params.compact)
  end

  def stub_update_request(args = {})
    body = args.fetch(:body, '')
    url = args.fetch(:url)

    stub_request(:post, url)
      .with(
        headers: authorized_headers(write: true)
      )
      .to_return(
        status: 200,
        body: body.to_json
      )
  end

  # Dynamically define helpers
  XERO_RECORD_COLLECTION.all.each do |record, opts|
    record = record.gsub('/', '_')
    url_method_name = "#{record}_url"

    define_method(url_method_name) do |**keywords|
      api_record_url(
        **{
          record: record
        }.merge(keywords)
      )
    end

    define_method("stub_#{record}_create") do |args = {}|
      method = args.fetch(:api_method, :post)
      stub_create_request(
        body: opts.hash,
        url: send(url_method_name),
        method: method
      )
    end

    define_method("stub_#{record}_delete") do
      stub_delete_request(
        url: send(
          url_method_name,
          id: opts.id
        )
      )
    end

    define_method("stub_#{record}_find") do |params = {}|
      stub_find_request(
        response_body: opts.hash,
        url: send(
          url_method_name,
          params: params,
          id: opts.id
        )
      )
    end

    define_method("stub_#{record}_update") do |args = {}|
      params = args.fetch(:params, {})
      id = args.fetch(:id, nil)
      body = args.fetch(:body, opts.hash)
      stub_update_request(
        body: body,
        url: send(
          url_method_name,
          params: params,
          id: id
        )
      )
    end
  end
end
