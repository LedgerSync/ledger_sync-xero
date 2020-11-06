# frozen_string_literal: true

require_relative 'oauth_client'

module LedgerSync
  module Xero
    class Client
      include Ledgers::Client::Mixin

      ROOT_URI = 'https://api.xero.com/api.xro/2.0'
      OAUTH_HEADERS = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }.freeze

      attr_reader :access_token,
                  :client_id,
                  :client_secret,
                  :expires_at,
                  :previous_refresh_tokens,
                  :refresh_token,
                  :refresh_token_expires_at,
                  :tenant_id,
                  :update_dotenv

      def initialize(args = {})
        @access_token = args.fetch(:access_token)
        @client_id = args.fetch(:client_id)
        @client_secret = args.fetch(:client_secret)
        @refresh_token = args.fetch(:refresh_token)
        @tenant_id = args.fetch(:tenant_id)
        @update_dotenv = args.fetch(:update_dotenv, true)

        @previous_access_tokens = []
        @previous_refresh_tokens = []

        update_secrets_in_dotenv if update_dotenv
      end

      def authorization_url(redirect_uri:)
        oauth_client.authorization_url(redirect_uri: redirect_uri)
      end

      def find(path:)
        url = "#{ROOT_URI}/#{path.capitalize}"

        request(
          headers: oauth_headers,
          method: :get,
          url: url
        )
      end

      def post(path:, payload:)
        url = "#{ROOT_URI}/#{path.capitalize}"

        request(
          headers: oauth_headers,
          method: :post,
          body: {
            path.capitalize => payload
          },
          url: url
        )
      end

      def oauth_headers
        OAUTH_HEADERS.dup.merge('Xero-tenant-id' => @tenant_id)
      end

      def oauth
        OAuth2::AccessToken.new(
          oauth_client.client,
          access_token,
          refresh_token: refresh_token
        )
      end

      def oauth_client
        @oauth_client ||= LedgerSync::Xero::OAuthClient.new(
          client_id: client_id,
          client_secret: client_secret
        )
      end

      def refresh!
        set_credentials_from_oauth_token(
          token: Request.new(
            client: self
          ).refresh!
        )
        self
      end

      def tenants
        response = oauth.get(
          '/connections',
          body: nil,
          headers: LedgerSync::Xero::Client::OAUTH_HEADERS.dup
        )
        JSON.parse(response.body)
      end

      def request(method:, url:, body: nil, headers: {})
        Request.new(
          client: self,
          body: body,
          headers: headers,
          method: method,
          url: url
        ).perform
      end

      def self.new_from_env(**override)
        new(
          {
            access_token: ENV.fetch('XERO_ACCESS_TOKEN'),
            client_id: ENV.fetch('XERO_CLIENT_ID'),
            client_secret: ENV.fetch('XERO_CLIENT_SECRET'),
            refresh_token: ENV.fetch('XERO_REFRESH_TOKEN'),
            tenant_id: ENV.fetch('XERO_TENANT_ID')
          }.merge(override)
        )
      end

      def set_credentials_from_oauth_code(code:, redirect_uri:)
        oauth_token = oauth_client.get_token(
          code: code,
          redirect_uri: redirect_uri
        )

        set_credentials_from_oauth_token(
          token: oauth_token
        )

        oauth_token
      end

      def set_credentials_from_oauth_token(token:) # rubocop:disable Metrics/CyclomaticComplexity,Naming/AccessorMethodName,Metrics/PerceivedComplexity
        @previous_access_tokens << access_token if access_token.present?
        @access_token = token.token

        @expires_at = Time&.at(token.expires_at.to_i)&.to_datetime
        unless token.params['x_refresh_token_expires_in'].nil?
          @refresh_token_expires_at = Time&.at(
            Time.now.to_i + token.params['x_refresh_token_expires_in']
          )&.to_datetime
        end

        @previous_refresh_tokens << refresh_token if refresh_token.present?
        @refresh_token = token.refresh_token
      ensure
        update_secrets_in_dotenv if update_dotenv
      end

      def self.ledger_attributes_to_save
        %i[access_token expires_at refresh_token refresh_token_expires_at]
      end
    end
  end
end
