require 'json'
require 'uri'
require 'net/https'

module Putio
  class Connection
    DEFAULT_ENDPOINT    = 'https://api.put.io'
    DEFAULT_API_VERSION = 'v2'
    attr_reader :endpoint

    def initialize(token:, endpoint:DEFAULT_ENDPOINT)
      @token    = token
      @endpoint = URI.parse(endpoint)
    end

    def get(path, params={})
      request_json(:get, path, params)
    end

    private
    attr_reader :token, :http

    def http
      @http ||= begin
        http             = Net::HTTP.new(endpoint.host, endpoint.port)
        http.use_ssl     = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http
      end
    end

    def request_json(method, path, params)
      resp = request(method, path, params)
      body = JSON.parse(resp.body)

      response_factory.call(code: resp.code.to_i, body: body)
    end

    def request(method, path, params)
      prefixed  = "/#{DEFAULT_API_VERSION}#{path}"
      params.merge!(oauth_token: token)
      full_path = encode_path_params(prefixed, params)

      # Our API is Readonly at the moment, so only GET
      request = Net::HTTP::Get.new(full_path, default_headers)
      http.request(request)
    end

    def encode_path_params(path, params)
      encoded = URI.encode_www_form(params)
      [path, encoded].join('?')
    end

    def response_factory
      @response_factory ||= ->(*args) { OpenStruct.new(*args) }
    end

    def default_headers
      { 'User-Agent' => 'putio-rb ruby client',
        'Accept' => 'application/json' }
    end
  end
end
