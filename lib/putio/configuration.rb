require 'dotenv'
Dotenv.load

module PutIO
  module Configuration
    VALID_OPTIONS_KEYS = [
      :client_id,
      :client_secret,
      :oauth_token,
      :api_version,
      :api_endpoint
    ].freeze

    DEFAULT_API_VERSION  = 2
    DEFAULT_API_ENDPOINT = ENV["PUTIO_API_ENDPOINT"] || "https://api.put.io/v2"
    DEFAULT_OAUTH_TOKEN  = ENV["PUTIO_OAUTH_TOKEN"]

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) { |options, key| options.merge!(key => send(key)) }
    end

    def reset
      self.client_id     = nil
      self.client_secret = nil
      self.oauth_token   = DEFAULT_OAUTH_TOKEN
      self.api_version   = DEFAULT_API_VERSION
      self.api_endpoint  = DEFAULT_API_ENDPOINT
    end
  end
end