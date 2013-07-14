require 'spec_helper'

describe PutIO::File do
  it 'can be created with a hash' do
    options = {:id => 1, :name => "Batman", :content_type => "file"}

    lambda { described_class.from_hash(options) }.should_not raise_error
  end
end

describe PutIO::Files do

end