module Putio

  # Configuration options for {Client}, defaulting to values
  # in {Default}
  module Configurable

    # @!attribute [w] access_token
    #   @see https://put.io/v2/docs/gettingstarted.html#authentication-and-access
    #   @return [String] OAuth2 access token for authentication
    # @!attribute api_endpoint
    #   @return [URI] Base URL for API requests. default: https://api.put.io/
    # @!attribute api_version
    #   @return [String] API version to use. default: v2
    # @!attribute user_agent
    #   @return [String] User agent for http requests. default: 'putio-rb ruby client'
    # @!attribute default_headers
    #   @return [Hash] Headers to use in http requests.
    attr_accessor :access_token, :api_endpoint, :api_version, :user_agent, :default_headers

    # List of configurable keys for {Putio::Client}
    # @return [Array] of option keys
    def self.keys
      @keys ||= %i{ access_token api_endpoint api_version user_agent default_headers }
    end

    # Configure options with a block
    def configure
      yield self
    end

    # Reset configuration options to default values
    def reset!
      Putio::Configurable.keys.each do |key|
        public_send("#{key}=".to_sym, Putio::Defaults.options[key])
      end
      self
    end
    alias setup reset!

    def options
      Hash[Putio::Configurable.keys.map { |key| [key, public_send(key.to_sym)] }]
    end
  end
end
