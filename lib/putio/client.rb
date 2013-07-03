require 'putio/connection'

module PutIO
  class Client

    attr_reader :connection

    def initialize(options = {})
      @connection ||= Connection.new(options)
    end

    def files_list
      response = @connection.get("/files/list")
      if response.success?
        response
      else
        require 'pry'; binding.pry
      end
    end

    def transfers_add(url, parent_id = 0, extract = false, callback = nil)
      Connection.post("/transfers/add", :body => url)
    end

  end
end