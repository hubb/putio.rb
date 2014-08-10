lib = File.expand_path('lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'putio/client'
require 'forwardable'

module Putio
  class << self
    include Putio::Configurable
    extend Forwardable

    def_delegators :client, :list_files, :files

    def client
      @client ||= Client.new(options)
    end
  end
end

Putio.setup
