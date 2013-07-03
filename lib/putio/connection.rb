require 'httparty'
require 'forwardable'

module PutIO
  class Connection
    extend Forwardable

    include HTTParty
    base_uri     Configuration::DEFAULT_API_ENDPOINT
    headers      'Accept' => 'application/json'
    format       :json
    debug_output $stderr

    def_delegator self, :get, :get #:post, :put, :delete

    def initialize options = {}
      self.class.default_params.merge! options
    end
    
  end
end