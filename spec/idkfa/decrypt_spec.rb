require 'spec_helper'
require 'stringio'

describe Idkfa::Decrypt do
  let(:idkfa) { Idkfa::Decrypt.new }
  let(:sym_key_encrypted) { 'encrypted!' }
  let(:sym_key_decrypted) { 'decrypted!' }
  let(:ciphertext) { 'ciphertext!' }

  describe '#decrypt' do

    it 'determines public/private keypair' do
      idkfa.should_receive(:determine_keypair)
      idkfa.decrypt ciphertext
    end

    it 'looks up the encrypted symmetric key' do
      idkfa.should_receive(:find_encrypted_symmetric_key)
      idkfa.decrypt ciphertext
    end

    it 'decrypts the symmetric key' do
      idkfa.stub(:find_encrypted_symmetric_key => sym_key_encrypted)
      idkfa.stub(:determine_keypair)
      idkfa.should_receive(:decrypt_symmetric_key).with(sym_key_encrypted)
      idkfa.decrypt ciphertext
    end

    it 'decrypts the content' do
      idkfa.stub(:find_encyrpted_symmetric_key => sym_key_encrypted)
      idkfa.stub(:decrypt_symmetric_key => sym_key_decrypted)
      idkfa.should_receive(:decrypt_ciphertext).
        with(:ciphertext => ciphertext, :key => sym_key_decrypted)
      idkfa.decrypt ciphertext
    end

  end

  describe '#determine_keypair' do

    context 'with keypair set in ENV' do

      before do
        ENV['idkfa_public_key'] = 'public key'
        ENV['idkfa_private_key'] = 'private key'
      end

      after do
        ENV.delete('idkfa_public_key')
        ENV.delete('idkfa_private_key')
      end

      it 'sets the keypair from ENV' do
        idkfa.send(:determine_keypair)
        idkfa.public_key.should == 'public key'
        idkfa.instance_variable_get("@private_key").should == 'private key'
      end

    end

    context 'without keypair set in ENV' do
      it 'sets the keypair from default location' do
        idkfa.should_receive(:set_keypair_from_files)
        idkfa.send(:determine_keypair)
      end
    end

  end

  describe '#set_keypair_from_files' do

    let(:private_filename) { File.expand_path('~/.ssh/id_rsa') }
    let(:private_file) { StringIO.new('foo!') }
    let(:public_filename) { File.expand_path('~/.ssh/id_rsa.pub') }
    let(:public_file) { StringIO.new('bar!') }

    it 'sets the keys' do
      File.should_receive(:open).with(private_filename).and_yield(private_file)
      File.should_receive(:open).with(public_filename).and_yield(public_file)
      idkfa.send(:set_keypair_from_files)
      idkfa.instance_variable_get("@private_key").should == 'foo!'
      idkfa.public_key.should == 'bar!'
    end

  end

  describe '#find_encrypted_symmetric_key' do
    it 'finds the encrypted symmetric key'
  end

end
