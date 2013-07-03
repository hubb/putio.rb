lib = File.expand_path('lib')
$:.unshift(lib) unless $:.include?(lib)

require 'putio/configuration'
require 'putio/client'
require 'cli'

module PutIO
  # extend Configuration
  
  def self.new(options = {})
    PutIO::Client.new(options)
  end

  def self.method_missing(method, *args, &block)
    return super unless new.respond_to?(method)
    new.send(method, *args, &block)
  end

  def self.respond_to?(method, with_private = false)
    new.respond_to?(method, with_private) || super(method, with_private)
  end

end