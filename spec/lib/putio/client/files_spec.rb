require 'spec_helper'

describe 'Putio::Client Files behaviour' do
  let(:files)      { File.read('spec/support/files.json') }
  subject(:client) { Putio::Client.new(access_token: 'foobar') }

  it { expect(client).to respond_to(:list_files) }
  it { expect(client).to respond_to(:files) }

  describe 'files' do
    before do
      stub_request(:get, "https://api.put.io/v2/files/list?oauth_token=foobar").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => files, :headers => {})
    end

    it 'should return a collection of Putio::Resource::File' do
      expect(client.list_files).to be_kind_of(Array)
      expect(client.list_files.first).to be_kind_of(Putio::Resource::File)
    end

    context 'when the response is empty' do
      before do
        stub_request(:get, "https://api.put.io/v2/files/list?oauth_token=foobar").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => "{\"files\":[]}", :headers => {})
      end

      it 'should return an empty collection' do
        expect(client.list_files).to be_kind_of(Array)
        expect(client.list_files).to be_empty
      end
    end
  end

  describe 'search' do
    before do
      stub_request(:get, "https://api.put.io/v2/files/search/foobar?oauth_token=foobar").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => files, :headers => {})
    end

    it 'should return a collection of Putio::Resource::File' do
      result = client.search(query: 'foobar')

      expect(result).to be_kind_of(Array)
      expect(result.first).to be_kind_of(Putio::Resource::File)
    end

    context 'when the response is empty' do
      before do
        stub_request(:get, "https://api.put.io/v2/files/search/foobar?oauth_token=foobar").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => "{\"files\":[]}", :headers => {})
      end

      it 'should return an empty collection' do
        result = client.search(query: 'foobar')

        expect(result).to be_kind_of(Array)
        expect(result).to be_empty
      end
    end

    context 'without query' do
      it { expect { client.search }.to raise_error }
    end

    context 'with a page' do
      it 'should query the right page' do
        mock_request = stub_request(:get, "https://api.put.io/v2/files/search/foobar/page/2?oauth_token=foobar").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => "{\"files\":[]}", :headers => {})

        client.search(query: 'foobar', options: { page: 2 })

        assert_requested(mock_request)
      end
    end

    context 'with other search syntax option' do
      it 'should query with the right options' do
        mock_request = stub_request(:get, "https://api.put.io/v2/files/search/foobar?ext=mp4&from=me&oauth_token=foobar&time=thisweek&type=video").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "{\"files\":[]}", :headers => {})

        client.search(query: 'foobar', options: { from: 'me', type: 'video', ext: 'mp4', time: 'thisweek' })

        assert_requested(mock_request)
      end
    end
  end
end
