require 'rspec'
require_relative '../lib/putio'
require_relative '../lib/cli'

$0 = "putio"
ARGV.clear

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end