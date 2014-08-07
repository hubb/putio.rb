module Putio
  File = Struct.new(:id, :name, :content_type, :created_at, :icon, :size) do
    def self.from_hash(options = {})
      id           = options.fetch("id")           { nil }
      name         = options.fetch("name")         { "" }
      content_type = options.fetch("content_type") { "" }
      created_at   = options.fetch("created_at")   { Time.now }
      icon         = options.fetch("icon")         { "" }
      size         = options.fetch("size")         { 0 }

      File.new(id, name, content_type, created_at, icon, size)
    end

    def download

    end
  end

  class Files

    attr_reader :client

    def initialize(client = nil)
      @client = client
      @list   = Array(list)
    end

    def list
      response = client.get("/files/list").parsed_response
      [].tap do |list|
        response["files"].each do |file_data|
          # with futures
          list.push future { File.from_hash(file_data) }

          # without
          # list.push File.from_hash(file_data)
        end
      end
    end

  end

end
