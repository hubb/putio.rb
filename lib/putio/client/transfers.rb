require 'putio/resource/transfer'

module Putio

  class Client

    module Transfers
      # Get all the transfers
      #
      # @return [Array]
      def list_transfers
        resp = get '/transfers/list'

        resp.body.fetch('transfers').inject([]) do |memo, data|
          memo.push transfer_factory.call(data)
        end
      end
      alias :transfers :list_transfers

      private
      def transfer_factory
        @transfer_factory ||= Putio::Resource::Transfer.public_method(:new)
      end
    end
  end
end
