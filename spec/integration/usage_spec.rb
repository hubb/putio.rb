require 'spec_helper'

describe 'Usages' do
  let(:response) { File.read('spec/support/files.json') }
  let(:token)    { "foobar" }

  before do
    stub_request(:get, "https://api.put.io/v2/files/list?oauth_token=foobar").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => response, :headers => {})
  end

  it 'allows to be used standalone' do
    Putio.access_token = token

    expect(Putio.list_files).not_to be_empty
    expect(Putio.files).not_to be_empty
  end

  it 'allows to detach the client and call methods on it' do
    Putio.access_token = token
    client = Putio.client

    expect(client.list_files).not_to be_empty
    expect(client.files).not_to be_empty
  end
end
