require 'putio/connection'
require 'forwardable'

module Putio
  class Client
    extend Forwardable
    attr_reader :options

    def initialize(options={})
      @options = options
    end

    def files
      resp = connection.get('/files/list')

      if resp.body.fetch('status') == 'OK'
        files = [].tap do |all|
          resp.body.fetch('files').each do |data|
            all << OpenStruct.new(data)
          end
        end
      end

      files
    end

    private
    def oauth_token
      options.fetch(:oauth_token)
    end

    def connection
      @connection ||= Connection.new(token: oauth_token)
    end

  end
end
