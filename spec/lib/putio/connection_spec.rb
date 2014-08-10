require 'spec_helper'
require 'putio/connection'

describe Putio::Connection do
  let(:endpoint) { Putio::Defaults.api_endpoint }
  subject(:connection) { described_class.new(endpoint: endpoint) }

  context 'without an endpoint' do
    it { expect { described_class.new }.to raise_error }
  end

  describe 'request' do
    let(:http) { double }

    context 'GET' do
      it 'should query the endpoint with URL encoded params' do
        stub_get = stub_request(:get, 'https://api.put.io/foo/bar?oauth_token=foobar').
          with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => "", :headers => {})

        connection.request(:get, '/foo/bar', oauth_token: 'foobar')

        assert_requested(stub_get)
      end
    end

    %i{ post put delete }.each do |method|
      context "#{method.upcase}" do
        it 'should query the endpoint with form encoded params' do
          stub_method = stub_request(method, 'https://api.put.io/foo/bar').
            with(body: { oauth_token: 'foobar', foo: 'bar' },
                 headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
            to_return(:status => 200, :body => "", :headers => {})

          connection.request(method, '/foo/bar', oauth_token: 'foobar', foo: 'bar')

          assert_requested(stub_method)
        end
      end
    end
  end

  describe 'request_json' do
    context 'response is 200' do
      it 'returns an OpenStruct with code and body' do
        stub_request(:get, "https://api.put.io/foo/bar").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "{}", :headers => {})

        resp = connection.request_json(:get, '/foo/bar', {})
        expect(resp).to respond_to(:code)
        expect(resp).to respond_to(:body)
        expect(resp.body).to be_empty
      end
    end

    context 'response is within 400 range' do
      it 'fails with a message' do
        stub_request(:get, "https://api.put.io/foo/bar").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 401, :body => "{}", :headers => {})

        expect { connection.request_json(:get, '/foo/bar', {}) }.to raise_error('bad request')
      end
    end

    context 'response is within 500 range' do
      it 'fails with a message' do
        stub_request(:get, "https://api.put.io/foo/bar").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 503, :body => "{}", :headers => {})

        expect { connection.request_json(:get, '/foo/bar', {}) }.to raise_error('server problems')
      end
    end
  end
end
