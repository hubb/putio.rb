require 'rspec'
require 'webmock/rspec'
include WebMock
WebMock.disable_net_connect!

# Stub requests
files_hash = {
  "files" => [{

  }, {

  }]
}

stub_request(:get, "https://api.put.io/v2/files/list?oauth_token=VALID%7CTOKEN").
         with(:headers => {'Accept'=>'application/json'}).
         to_return(:status => 200, :body => files_hash, :headers => {})

require_relative '../lib/putio'

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