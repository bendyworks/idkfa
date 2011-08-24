require 'spec_helper'
require 'idkfa/authorization'

describe Idkfa::Authorization do
  describe '#initialize' do
    it 'generates public/private keys' do
      Idkfa::OpenSSL::Asymmetric.should_receive(:new).and_return(mock('asymmetric key'))
      Idkfa::Authorization.new
    end
  end

  describe '.key_name_from_system' do
    # TODO: Make sure this works on Win32
    it 'uses current login and hostname' do
      Etc.stub :getlogin => 'user'
      Socket.stub :gethostname => 'hostname'
      Idkfa::Authorization.key_name_from_system.should == "#{user}@#{hostname}"
    end
  end

end
