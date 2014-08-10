require 'spec_helper'

describe Putio::Defaults do
  it { expect(described_class).to respond_to(:api_endpoint) }
  it { expect(described_class).to respond_to(:api_version) }
  it { expect(described_class).to respond_to(:default_headers) }
  it { expect(described_class).to respond_to(:user_agent) }

  describe '.api_endpoint' do
    it { expect(described_class.api_endpoint).to be_kind_of(String) }
    it { expect(described_class.api_endpoint.to_s).to eq("https://api.put.io") }
  end

  describe '.api_version' do
    it { expect(described_class.api_version).to be_kind_of(String) }
    it { expect(described_class.api_version).to eq('v2') }
  end

  describe '.default_headers' do
    it { expect(described_class.default_headers).to be_kind_of(Hash) }
    it { expect(described_class.default_headers).to include('User-Agent' => 'putio-rb ruby client') }
    it { expect(described_class.default_headers).to include('Accept' => 'application/json') }
  end

  describe '.options' do
    it { expect(described_class.options).to be_kind_of(Hash) }
  end

  describe '.access_token' do
    it { expect(described_class.access_token).to be_nil }

    context 'configured through ENV variable' do
      before { ENV['PUTIO_ACCESS_TOKEN'] = 'foobar' }
      it     { expect(described_class.access_token).to eq('foobar') }
    end
  end
end
