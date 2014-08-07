require 'httparty'
require 'forwardable'
require 'Putio/configuration'

module Putio
  class Connection

    class MissingOauthToken < ArgumentError
      def initialize; super("Unable to authenticate without a token"); end
    end

    extend Forwardable

    include HTTParty
    base_uri     Configuration::DEFAULT_API_ENDPOINT
    headers      'Accept' => 'application/json'
    format       :json
    # debug_output $stderr

    def_delegators self, :get, :post, :put, :delete

    def initialize(token = nil)
      raise MissingOauthToken.new if token.nil?
      self.class.default_params.merge!(oauth_token: token)
    end

  end
end
