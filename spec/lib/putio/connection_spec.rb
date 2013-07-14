require 'spec_helper'

describe PutIO::Connection do

  context 'without OAuth token' do
    it 'raises an error' do
      lambda { subject }.should raise_error(described_class::MissingOauthToken)
    end
  end

  context 'with OAuth token' do

    subject { described_class.new("VALID_TOKEN") }

    it 'does not raise any error' do
      lambda { subject }.should_not raise_error
    end

    context 'httparty-able' do

      it 'includes HTTParty' do
        subject.is_a?(HTTParty).should be_true
      end

      it 'has base_uri' do
        subject.class.base_uri.should eql(PutIO::Configuration::DEFAULT_API_ENDPOINT)
      end

      it 'has right headers' do
        subject.class.headers.should eql('Accept' => 'application/json')
      end

      it 'has right format' do
        subject.class.format.should eql(:json)
      end

      it 'has a token' do
        subject.class.default_params.should eql({:oauth_token => "VALID_TOKEN"})
      end

      %I(get post put delete).each do |meth|
        it "delegates #{meth} to the class" do
          PutIO::Connection.should_receive(meth)
          subject.send(meth)
        end
      end

    end

  end
end