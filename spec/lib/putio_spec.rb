require 'spec_helper'

describe PutIO do
  it 'creates new client' do
    PutIO::Client.should_receive(:new).with(oauth_token: "VALIDTOKEN")
    described_class.new(oauth_token: "VALIDTOKEN")
  end
end