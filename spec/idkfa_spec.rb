require 'spec_helper'

describe Idkfa do
  let(:config) { {"staging" => {"key" => 'staging-key'}, "production" => {"key" => 'prod'}} }

  before do
    ENV.delete('KEY')
  end

  describe '.load_keys' do
    before { subject.stub(:load_yaml => config) }

    context 'provided staging environment' do
      it "sets ENV[KEY]" do
        Idkfa.load_keys :staging, :credentials => '/foo.txt'
        ENV['KEY'].should == 'staging-key'
      end
    end

    context 'without credentials' do
      shared_examples_for :raises_without_credentials_path do
        it 'raises' do
          lambda do
            run
          end.should raise_error("You must provide :credentials => 'file.yml'")
        end
      end

      context 'with environment' do
        def run; Idkfa.load_keys(:development); end
        it_should_behave_like :raises_without_credentials_path
      end

      context 'without environment' do
        def run; Idkfa.load_keys; end
        it_should_behave_like :raises_without_credentials_path
      end

    end
  end

  describe '.load_yaml' do

    context 'a valid credentials path' do
      it 'returns the parsed file' do
        Idkfa.send(:load_yaml, File.expand_path('../fixtures/dummy.yml', __FILE__)).should == config
      end
    end

    context 'with invalid credentials path' do
      it 'raises Errno::ENOENT' do
        lambda do
          Idkfa.send(:load_yaml, File.expand_path('../fixtures/non_existent_yaml.yml', __FILE__))
        end.should raise_error(Errno::ENOENT)
      end
    end

  end
end
