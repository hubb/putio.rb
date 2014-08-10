require 'spec_helper'
require 'putio/resource/file'

describe Putio::Resource::File do
  subject(:file) { described_class.new }

  it 'has a set of valid keys' do
    expect(described_class::VALID_KEYS).not_to be_empty
  end

  describe 'interface' do
    described_class::VALID_KEYS.each do |key|
      it { expect(file).to respond_to(key) }
    end
  end

  context 'when content_type is application/x-directory' do
    before { allow(file).to receive(:content_type).and_return('application/x-directory') }
    it     { expect(file).to be_directory }
  end

  context 'when is_shared is true' do
    before { allow(file).to receive(:is_shared).and_return(true) }
    it     { expect(file).to be_shared }
  end

  context 'when is_mp4_available is true' do
    before { allow(file).to receive(:is_mp4_available).and_return(true) }
    it     { expect(file).to be_mp4_available }
  end

  describe 'created_at' do
    before { allow(file).to receive(:created_at).and_return(Time.now) }
    it     { expect(file.created_at).to be_kind_of(Time) }
  end
end
