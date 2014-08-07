require 'forwardable'

require 'connection'
require 'files'
require 'future'

module Putio
  class Client

    extend Forwardable

    def initialize(token:)
      self.oauth_token = token
    end

    def transfers_add(url, parent_id = 0, extract = false, callback = nil)
      connection.post("/transfers/add", :body => url)
    end


    private
    attr_reader :oauth_token

    def_delegators :connection, :get, :post, :put, :delete
    def connection
      @connection ||= Connection.new(oauth_token)
    end

    def extract_token(args)
      if args[0] && !args[0].is_a?(Array)
        args[0][:oauth_token] || nil
      else
        nil
      end
    end

  end
end
