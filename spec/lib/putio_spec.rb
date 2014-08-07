require 'spec_helper'
require 'putio'

describe Putio do
  let(:config) { double }

  it 'has a configuration' do
    expect(Putio.configuration).not_to be_nil
  end

  describe 'configure' do
    it 'yield a configuration' do
      expect(Putio).to receive(:configuration).and_return(config)

      expect { |config|
        Putio.configure(&config)
      }.to yield_successive_args(config)
    end
  end

  describe 'client' do
    it 'gives the configuration to the client' do
      allow(Putio).to receive(:configuration).and_return(config)

      expect(config).to receive(:to_h).and_return({})
      expect(Putio::Client).to receive(:new).with(instance_of(Hash))

      Putio.client
    end
  end

end
