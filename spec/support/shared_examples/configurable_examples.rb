shared_examples 'a configurable' do
  before { subject.reset! }
  after  { subject.reset! }

  it { expect(subject).to respond_to(:configure) }
  it { expect(subject).to respond_to(:setup) }
  it { expect(subject).to respond_to(:reset!) }
  it { expect(subject).to respond_to(:options) }

  describe 'interface' do
    Putio::Configurable.keys.each do |key|
      it { expect(subject).to respond_to(key) }
      it { expect(subject).to respond_to("#{key}=".to_sym) }
    end
  end

  describe 'configure' do
    shared_examples 'setting instance variables' do
      it 'should be different than the default values' do
        expect(subject.options).not_to eq(Putio::Defaults.options)
      end
      it { expect(subject.access_token).to eq('foobar') }
      it { expect(subject.api_endpoint).to eq('http://api.put.io.test') }
      it { expect(subject.api_version).to eq('v1') }
      it { expect(subject.user_agent).to eq('putio-rb testing') }
      it { expect(subject.default_headers).to eq(
        {
          'User-Agent' => 'putio-rb ruby client',
          'Accept' => 'application/json',
          'X-Test' => 'Yes'
        }
      )}
    end

    context 'using a block' do
      before do
        subject.configure do |c|
          c.access_token = 'foobar'
          c.api_endpoint = 'http://api.put.io.test'
          c.api_version  = 'v1'
          c.user_agent   = 'putio-rb testing'
          c.default_headers.merge!({ 'X-Test' => 'Yes' })
        end
      end

      it_behaves_like 'setting instance variables'
    end

    context 'using accessors' do
      before do
        subject.access_token = 'foobar'
        subject.api_endpoint = 'http://api.put.io.test'
        subject.api_version  = 'v1'
        subject.user_agent   = 'putio-rb testing'
        subject.default_headers.merge!({ 'X-Test' => 'Yes' })
      end

      it_behaves_like 'setting instance variables'
    end
  end

  describe 'reset!' do
    before do
      subject.configure do |c|
        c.access_token = 'foobar'
        c.api_endpoint = 'http://api.put.io.test'
        c.api_version  = 'v1'
        c.user_agent   = 'putio-rb testing'
      end
    end

    it 'should set the options to their defaults values' do
      expect {
        subject.reset!
      }.to change {
        subject.options
      }.to(Putio::Defaults.options)
    end

    it 'should be aliased as setup' do
      expect(subject).to respond_to(:setup)
    end
  end
end
