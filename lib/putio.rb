lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'putio/configuration'
require 'putio/client'

module Putio
  def self.configure
    yield configuration
    true
  end

  def self.client
    @client ||= Client.new(configuration.to_h)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
