require 'spec_helper'
require 'putio/client'

describe Putio::Client do
  let(:access_token) { 'foobar' }
  subject(:client) { described_class.new(access_token: access_token) }

  it_behaves_like 'a configurable'

  # TODO: extract to files shared examples
  it { expect(client).to respond_to(:list_files) }
  # TODO: extract to transfers shared examples
  it { expect(client).to respond_to(:list_transfers) }

  describe 'inspect' do
    it { expect(client.inspect).to be_kind_of(String) }

    it 'should hide the access token' do
      expect(client.inspect).not_to include(access_token)
      expect(client.inspect).to include('*******')
    end
  end

  it { expect(subject).to respond_to(:get) }
  it { expect(subject).to respond_to(:post) }
  it { expect(subject).to respond_to(:put) }
  it { expect(subject).to respond_to(:delete) }

  describe 'request' do
    let(:connection) { double }
    before do
      allow(connection).to receive(:request_json).and_return(true)
      client.connection = connection
    end

    it 'should add the access_token to the params' do
      expect(connection).to receive(:request_json).with(anything, anything, hash_including(:oauth_token))
      client.get('/foo/bar')
    end

    it 'should prepend the path with the api version' do
      expect(connection).to receive(:request_json).with(anything, '/v2/foo/bar', anything)
      client.get('/foo/bar')
    end

    %i{ get post put delete }.each do |method|
      context "when the method is #{method.upcase}" do
        it "should make a #{method.upcase} request" do
          expect(connection).to receive(:request_json).with(method, anything, anything)
          client.public_send(method, '/foo/bar')
        end
      end
    end
  end

  describe 'connection' do
    let(:connection) { double(request_json: true) }

    it 'should be initialised with the client endpoint and default_headers' do
      expect(Putio::Connection).to receive(:new)
        .with(endpoint: client.api_endpoint, headers: client.default_headers)
        .and_return(connection)

      client.get('/foo/bar')
    end
  end
end
