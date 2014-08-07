require 'spec_helper'
require 'putio/connection'

describe Putio::Connection do
  subject(:connection) { described_class.new(token: 'test') }

  it 'needs a token' do
    expect { described_class.new }.to raise_error
  end

  it 'responds to get' do
    expect(connection).to respond_to(:get)
  end

  describe 'get' do
    let(:response) { connection.get('/foo/bar') }

    before do
      stub_request(:get, "https://api.put.io/v2/foo/bar?oauth_token=test").
         with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'putio-rb ruby client'}).
         to_return(:status => 200, :body => "[]", :headers => {})
    end

    it 'parses the response body' do
      expect(JSON).to receive(:parse).and_call_original
      response
    end

    it 'returns an object with a code and a body' do
      expect(response.code).to eq(200)
      expect(response.body).to eq([])
    end
  end
end
