require 'json'
require 'uri'
require 'net/http'

module Putio

  class Connection
    VERB_MAP = {
      get:    Net::HTTP::Get,
      post:   Net::HTTP::Post,
      put:    Net::HTTP::Put,
      delete: Net::HTTP::Delete
    }

    def initialize(endpoint:, headers:{})
      @endpoint = URI.parse(endpoint)
      @headers  = headers
    end

    def request_json(method, path, params)
      response = request(method, path, params)

      case response.code.to_i
      when 200 || 201
        body = JSON.parse(response.body)
        response_factory.call(code: response.code.to_i, body: body)
      when (400..499)
        fail 'bad request'
      when (500..599)
        fail 'server problems'
      end
    end

    def request(method, path, params)
      case method
      when :get
        full_path = encode_path_params(path, params)
        request = VERB_MAP[method].new(full_path)
      else
        request = VERB_MAP[method].new(path)
        request.set_form_data(params)
      end

      http.request(request)
    end

    private
    attr_reader :endpoint

    def http
      @http ||= begin
        http             = Net::HTTP.new(endpoint.host, endpoint.port)
        http.use_ssl     = endpoint.scheme == 'https'
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http.set_debug_output $stdout
        http
      end
    end

    def encode_path_params(path, params)
      encoded = URI.encode_www_form(params)
      [path, encoded].join('?')
    end

    def response_factory
      @response_factory ||= ->(*args) { OpenStruct.new(*args) }
    end
  end
end
