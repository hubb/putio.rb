require 'spec_helper'

describe PutIO::Client do
  
  context 'with auth token' do
    it 'creates a connection' do
      PutIO::Connection.should_receive(:new).with(oauth_token: "VALID|TOKEN")
      described_class.new oauth_token: "VALID|TOKEN"
    end
  end

end