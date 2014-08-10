require 'spec_helper'

describe Putio do
  it_behaves_like 'a configurable'

  describe 'client' do
    let(:access_token) { 'foobar' }
    before { Putio.configure { access_token = access_token } }
    it     { expect(Putio.client).to be_kind_of(Putio::Client) }

    it 'should memoize the client' do
      expect(Putio.client).to eq(Putio.client)
    end

    it 'should have a client with the same options' do
      expect(Putio.client.options).to eq(Putio.options)
    end
  end

end
