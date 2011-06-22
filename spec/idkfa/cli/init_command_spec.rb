require 'spec_helper'
require 'idkfa/cli/init_command'

describe Idkfa::CLI::InitCommand do
  include Idkfa::CLI

  describe '#run' do
    subject { InitCommand.new([]) }
    after { subject.run }

    context 'when keypair directory exists' do
      before { Idkfa::OpenSSL.stub(:keypair_exists?).and_return(true) }
      it 'does not create a keypair' do
        Idkfa::OpenSSL.should_not_receive(:create_keypair)
      end
    end

    context 'when keypair directory does not exist' do
      before { Idkfa::OpenSSL.stub(:keypair_exists?).and_return(false) }
      it 'creates a keypair' do
        Idkfa::OpenSSL.should_receive(:create_keypair).and_return(nil)
      end
    end

    context 'when credentials file exists' do
      before do
        subject.stub(:credentials_file_exists?).and_return(true)
        Idkfa::OpenSSL.stub(:create_keypair)
      end

      it 'does not create a credentials file' do
        subject.should_not_receive(:create_credentials_file)
      end
    end

    context 'when credentials file does not exist' do
      before do
        subject.stub(:credentials_file_exists?).and_return(false)
        Idkfa::OpenSSL.stub(:create_keypair)
      end

      it 'creates a credentials file' do
        subject.should_receive(:create_credentials_file).and_return(nil)
      end
    end

  end
end
