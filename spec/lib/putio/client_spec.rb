require 'spec_helper'
require 'putio/client'

describe Putio::Client do
  it 'is initialised with a hash of options' do
    expect(Putio::Client.new.options).to be_empty
  end
end
