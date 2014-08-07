require 'spec_helper'

describe Putio::Client do

  it 'can create a new instance' do
    described_class.should respond_to(:new)
  end

  context 'creating a new instance' do

    it 'sets the token' do
      client = described_class.new(oauth_token: "VALID|TOKEN")
      client.oauth_token.should eql("VALID|TOKEN")
    end

  end

end
