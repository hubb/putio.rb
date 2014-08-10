require 'spec_helper'
require 'putio/configurable'

describe Putio::Configurable do
  it { expect(described_class).to respond_to(:keys) }

  let(:klass)   { Class.new { include Putio::Configurable } }
  subject(:obj) { klass.new }

  it { expect(obj).to respond_to(:configure) }

  describe 'configuring the object' do
    before do
      obj.configure do
        access_token = 'foobar'
        api_endoint  = 'http://api.put.io.test'
        api_version  = 'v1'
        user_agent   = 'putio-rb testing'
      end
    end

    it { expect(obj.options).not_to eq(Putio::Defaults.options) }
  end

  describe 'reset!' do
    before do
      obj.configure do
        access_token = 'foobar'
        api_endoint  = 'http://api.put.io.test'
        api_version  = 'v1'
        user_agent   = 'putio-rb testing'
      end
    end

    it 'sets all the options back to their defaults values' do
      obj.reset!
      expect(obj.options).to eq(Putio::Defaults.options)
    end

    it 'is aliased as setup' do
      expect(obj).to respond_to(:setup)
    end
  end
end
