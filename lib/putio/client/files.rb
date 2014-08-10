require 'putio/resource/file'

module Putio

  class Client

    module Files
      # Get all the files
      #
      # @return [Array]
      def list_files
        resp = get '/files/list'
        resp.body["files"].inject([]) do |memo, data|
          memo.push resource_factory.call(data)
        end
      end
      alias :files :list_files

      private
      def resource_factory
        @resource_factory ||= Putio::Resource::File.public_method(:new)
      end
    end
  end
end
