require 'spec_helper'
require 'idkfa/authorization'

describe Idkfa::Authorization do
  describe '#initialize' do
    let(:asym_key) { mock('asym key', :encrypt => 'encrypted') }
    let(:authorization) { Idkfa::Authorization.new 'fake symmetric key' }
    before do
      Idkfa::OpenSSL::Asymmetric.should_receive(:new).and_return(asym_key)
    end

    it 'generates public/private keys' do
      authorization.asymmetric_key.should == asym_key
    end

    it 'encrypts the symmetric key' do
      authorization.encrypted_symmetric_key.should == 'encrypted'
    end

  end

  describe '.key_name_from_system' do
    # TODO: Make sure this works on Win32
    it 'uses current login and hostname' do
      Etc.stub :getlogin => 'user'
      Socket.stub :gethostname => 'hostname'
      Idkfa::Authorization.key_name_from_system.should == "user@hostname"
    end
  end

end
