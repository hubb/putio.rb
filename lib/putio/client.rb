require 'forwardable'

require_relative 'connection'
require_relative 'files'
require_relative 'future'

module PutIO
  class Client

    extend Forwardable

    attr_reader :oauth_token, :connection, :files

    def initialize(*args)
      @oauth_token = extract_token(args)
      @connection  = connection
      @files       = Files.new(self)
    end

    def transfers_add(url, parent_id = 0, extract = false, callback = nil)
      connection.post("/transfers/add", :body => url)
    end


    private

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