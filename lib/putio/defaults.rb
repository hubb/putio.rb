require 'uri'

module Putio

  # Default configuration options for the client
  module Defaults

    # Default API endpoint
    API_ENDPOINT = 'https://api.put.io'

    # Default API version
    API_VERSION = 'v2'

    # Default User Agent
    USER_AGENT = 'putio-rb ruby client'

    class << self
      # Configuration options
      # @return [Hash]
      def options
        Hash[Putio::Configurable.keys.map { |k| [k, public_send(k)] }]
      end

      # Default access token from ENV
      # @return [String]
      def access_token
        ENV['PUTIO_ACCESS_TOKEN']
      end

      # Default API endpoint from ENV or {API_ENDPOINT}
      # @return [String]
      def api_endpoint
        ENV.fetch('API_ENDPOINT', API_ENDPOINT)
      end

      # Default API version from ENV or {API_VERSION}
      # @return [String]
      def api_version
        ENV.fetch('API_VERSION', API_VERSION)
      end

      # Default User Agent from ENV or {USER_AGENT}
      # @return [String]
      def user_agent
        ENV.fetch('USER_AGENT', USER_AGENT)
      end

      # Default headers for our http requests
      # @return [Hash]
      def default_headers
        {
          'User-Agent' => "#{user_agent}",
          'Accept'     => 'application/json'
        }
      end
    end
  end

end
