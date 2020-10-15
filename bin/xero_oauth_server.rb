# frozen_string_literal: true

# Setup
#
# gem install bundler
# Ensure you have http://localhost:5678 (or PORT) as a Redirect URI in QBO.

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'dotenv'
  gem 'ledger_sync'
  gem 'ledger_sync-xero', path: '../'
  gem 'rack'
  gem 'pd_ruby'
end

puts 'Gems installed and loaded!'

require 'pd_ruby'
require 'socket'
require 'dotenv'
require 'rack'
require 'ledger_sync'
require 'rack/lobster'
Dotenv.load

port = ENV.fetch('PORT', 5678)
server = TCPServer.new(port)

base_url = "http://localhost:#{port}"

puts "Listening at #{base_url}"

client_id = ENV.fetch('CLIENT_ID')

raise 'CLIENT_ID not set in ../.env' if client_id.blank?

client = LedgerSync::Ledgers::Xero::Client.new_from_env

puts 'Go to the following URL:'
puts client.authorization_url(redirect_uri: base_url)

# Empty First Request
session = server.accept
session.gets
session.close

session = server.accept
request = session.gets

_path, query = request.split('?')

code = Hash[query.split('&').map { |e| e.split('=') }].fetch('code')

client.set_credentials_from_oauth_code code: code, redirect_uri: base_url

puts "access_token: \t #{client.access_token}\n"
puts "client_id: \t #{client.client_id}\n"
puts "client_secret: \t #{client.client_secret}\n"
puts "refresh_token: \t #{client.refresh_token}\n"
puts "expires_at: \t #{client.oauth.expires_at}\n"
puts "tenants:"

client.tenants.each do |tenant|
  puts "\t #{tenant['tenantName']} (#{tenant['tenantType']}) - #{tenant['tenantId']}"
end

body = 'Done'

headers = {
  'Content-Length' => body.size
}

session.print "HTTP/1.1 200\r\n"

headers.each do |key, value|
  session.print "#{key}: #{value}\r\n"
end

session.print "\r\n"
session.print body
session.close

puts 'Session Ended'