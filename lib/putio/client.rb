require 'putio/connection'
require 'putio/defaults'
require 'putio/configurable'
require 'putio/client/files'
require 'putio/client/transfers'

module Putio
  class Client
    include Putio::Configurable
    include Putio::Client::Files
    include Putio::Client::Transfers

    attr_writer :connection

    def initialize(options = {})
      Putio::Configurable.keys.each do |key|
        public_send(:"#{key}=", options.fetch(key) { Putio.public_send(:"#{key}") })
      end
    end

    # Text representation of the client, access token being masked
    #
    # @return [String]
    def inspect
      inspected = super
      # mask access_token
      inspected = inspected.gsub! access_token, "*******" if access_token
      inspected
    end

    # Make a HTTP GET request
    #
    # @param path [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Putio::Resource]
    def get(path, options = {})
      request :get, path, options
    end

    # Make a HTTP POST request
    #
    # @param path [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Putio::Resource]
    def post(path, options = {})
      request :post, path, options
    end

    # Make a HTTP PUT request
    #
    # @param path [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Putio::Resource]
    def put(path, options = {})
      request :put, path, options
    end

    # Make a HTTP DELETE request
    #
    # @param path [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Putio::Resource]
    def delete(path, options = {})
      request :delete, path, options
    end

    private
    def request(method, path, params)
      params = params.merge(oauth_token: access_token)
      path   = File.join('/', api_version, path)

      connection.request_json(method, path, params)
    end

    def connection
      @connection ||= Connection.new(endpoint: api_endpoint,
                                      headers: default_headers)
    end

  end
end
