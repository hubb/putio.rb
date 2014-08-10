module Putio

  class Client

    module Transfers
      # Get all the files
      #
      # @return [Array]
      def list_transfers
        resp = connection.get('/transfers/list')

        if resp.body.fetch('status') == 'OK'
          transfers = [].tap do |all|
            resp.body.fetch('transfers').each do |data|
              all << OpenStruct.new(data)
            end
          end
        end
      end

    end
  end
end
