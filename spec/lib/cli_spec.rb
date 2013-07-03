require 'spec_helper'

describe PutIO::Cli do

  let(:hello) { PutIO::Cli.start(["hello"]) }

  it 'should say hello' do
    pending "CLI in progress"
    $stdin.should_receive(:gets).and_return('hubb')
    res = capture(:stdout) { hello }
    res.should =~ "Hello hubb"
  end
end