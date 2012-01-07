require 'spec_helper'
require 'idkfa/cli/init_command'

describe Idkfa::CLI::InitCommand do
  include Idkfa

  describe '#initialize' do
    subject { CLI::InitCommand.new args }
    context 'passed no args' do
      let(:args) { [] }
      context 'without a config directory' do
        before { Dir.stub(:exists? => false) }
        its(:config_file) { should == "#{Idkfa.project_directory}/credentials.yml" }
      end
      context 'with a config directory' do
        before { Dir.stub(:exists? => true) }
        its(:config_file) { should == "#{Idkfa.project_directory}/config/credentials.yml" }
      end
    end
    context 'passed a config_file arg' do
      let(:args) { %w(-c cred.yml) }
      its(:config_file) { should == 'cred.yml' }
    end
  end

  describe '#run' do
    subject { CLI::InitCommand.new([]) }
    # after { subject.run }

    # context 'when keypair directory exists' do
    #   before { Idkfa::OpenSSL::Asymmetric.stub(:keypair_exists?).and_return(true) }
    #   it 'does not create a keypair' do
    #     Idkfa::OpenSSL::Asymmetric.should_not_receive(:create_keypair)
    #   end
    # end

    # context 'when keypair directory does not exist' do
    #   before { Idkfa::OpenSSL::Asymmetric.stub(:keypair_exists?).and_return(false) }
    #   it 'creates a keypair' do
    #     Idkfa::OpenSSL::Asymmetric.should_receive(:create_keypair).and_return(nil)
    #   end
    # end

    # context 'when credentials file exists' do
    #   before do
    #     subject.stub(:credentials_file_exists?).and_return(true)
    #     Idkfa::OpenSSL::Asymmetric.stub(:create_keypair)
    #   end

    #   it 'does not create a credentials file' do
    #     subject.should_not_receive(:create_credentials_file)
    #   end
    # end

    # context 'when credentials file does not exist' do
    #   before do
    #     subject.stub(:credentials_file_exists?).and_return(false)
    #     Idkfa::OpenSSL::Asymmetric.stub(:create_keypair)
    #   end

    #   it 'creates a credentials file' do
    #     subject.should_receive(:create_credentials_file).and_return(nil)
    #   end
    # end

  end
end
