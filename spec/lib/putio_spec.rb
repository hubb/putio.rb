require 'spec_helper'

describe PutIO do

  it 'offers a shortcut to create a new client' do
    lambda { described_class.new }.call.should be_a(PutIO::Client)
  end
  
end