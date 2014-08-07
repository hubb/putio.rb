require 'spec_helper'

describe Putio do

  it 'offers a shortcut to create a new client' do
    lambda { described_class.new }.call.should be_a(Putio::Client)
  end

end
