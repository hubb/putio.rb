lib = File.expand_path('lib')
$:.unshift(lib) unless $:.include?(lib)

class Putio
  extend Forwardable
  attr_reader :client

  def_delegators :client, :files, :add_file, :transfers, :add_transfer

  def initialize(auth_token:)
    @client = Client.new(auth_token)
  end
end
