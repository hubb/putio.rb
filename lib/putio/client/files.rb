require 'putio/resource/file'

module Putio

  class Client

    module Files
      # Lists files in a folder
      #
      # @param options [Hash]
      # @option options [Integer] parent_id: ID of the folder you’d like to list. This defaults to the root directory (which has ID number 0).
      # @alias files
      #
      # @return [Array<Putio::Resource::File>]
      def list_files(options:{})
        defaults = { parent_id: 0 }
        options  = defaults.merge!(options)

        resp = get '/files/list', options
        resp.body["files"].inject([]) do |memo, data|
          memo.push file_factory.call(data)
        end
      end
      alias :files :list_files

      # Search a file
      #
      # @param query [String] The keyword to search
      # @param options [Hash] Search Syntax params
      # @option options [Integer] page:  Defaults to 1. If -1 given, returns all results at a time.
      # @option options [String] from:  me, shares, jack or all
      # @option options [String] type: video, audio, image, iphone or all
      # @option options [String] ext:  mp3, avi, jpg, mp4 or all
      # @option options [String] time: today, yesterday, thisweek or all
      # @example
      #   result = client.search(query: "foo")
      #   # => returns first page of results for "foo"
      #
      #   result = client.search(query: "foo", page: 2)
      #   # => returns page 2 of results for "foo"
      #
      #   result = client.search(query: "foo", page:-1)
      #   # => returns all results for "foo"
      #
      #   result = client.search(query: 'jazz', options: { from: 'me,jack', ext: 'mp4', time: 'today' })
      #   # => Searches yours and jack’s files with the word jazz in its title which has the extension mp3 and created today.
      #
      #   result = client.search(query: 'jazz album', options: { from: 'shares', time: 'thisweek' })
      #   # => Searches items shared with you with jazz album which are created thisweek
      #
      #   result = client.search(query: 'jazz', options: { type: 'iphone' })
      #   # => Searches your files and items shared with the word jazz in its title which are converted to mp4
      #
      # @return [Array<Putio::Resource::File>]
      def search(query:, options: {})
        valid_search_options = %i{ page from type ext time }
        options.select! { |o| valid_search_options.include?(o) }

        page = options.delete(:page)
        path = if page
          "/files/search/#{query}/page/#{page}"
        else
          "/files/search/#{query}"
        end

        resp = get path, options

        resp.body["files"].inject([]) do |memo, data|
          memo.push file_factory.call(data)
        end
      end

      # Returns a file’s properties.
      #
      # @param id [Integer]
      # @param options
      # @option options [Integer] parent_id: ID of the folder you’d like to list. This defaults to the root directory (which has ID number 0).
      # @return [Putio::Resource::File]
      def file(id:, options:{})
        defaults = { parent_id: 0 }
        options  = defaults.merge!(options)

        resp = get "/files/#{id}", options
        file_factory.call(resp.body["file"])
      end

      # Deletes given files
      #
      # @param file_ids [Array<Integer>] File ids separated by commas. Ex: 1,2,3,4
      # Returns [true]
      def delete_file(*file_ids)
        resp = post '/files/delete', { file_ids: file_ids.join(',') }

        if resp.body["status"] == "OK"
          true
        else
          false
        end
      end

      private
      def file_factory
        @file_factory ||= Putio::Resource::File.public_method(:new)
      end
    end
  end
end
