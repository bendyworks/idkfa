require 'spec_helper'
require 'idkfa/open_ssl'

describe Idkfa::OpenSSL do
  let(:home_dir) { '/tmp/idkfa/.idkfa' }
  let(:pub_key) { 'foo' }
  let(:priv_key) { 'bar' }
  let(:keys) { {:public_key => pub_key, :private_key => priv_key} }

  describe "#write_keypair" do

    subject { Idkfa::OpenSSL }
    it "creates a keypair directory" do
      subject.stub(:write_key)
      subject.should_receive(:create_keypair_directory).and_return(home_dir)
      Idkfa::OpenSSL.write_keypair 'default', keys
    end

    it "writes the public key to disk" do
      subject.stub(:write_key)
      subject.should_receive(:write_key).with("#{home_dir}/default.public.yml", pub_key)
      Idkfa::OpenSSL.write_keypair 'default', keys
    end

    it "writes the private key to disk" do
      subject.stub(:write_key)
      subject.should_receive(:write_key).with("#{home_dir}/.default.private.yml", priv_key, :chmod => 0600)
      Idkfa::OpenSSL.write_keypair 'default', keys
    end
  end

  describe '#write_key' do
    let(:filename) { "#{home_dir}/.default.private.yml" }
    before { FileUtils.mkdir_p home_dir }

    context 'passed a :chmod in opts' do
      it 'chmods the file' do
        FileUtils.should_receive(:chmod).with(0600, filename)
        Idkfa::OpenSSL.write_key filename, priv_key, :chmod => 0600
      end
    end

    context 'no passed opts' do
      it 'does not chmod the file' do
        FileUtils.should_not_receive(:chmod)
        Idkfa::OpenSSL.write_key filename, priv_key
      end
    end
  end
  
  describe '#create_keypair' do
    after { Idkfa::OpenSSL.create_keypair }

    it 'generates the keypair' do
      Idkfa::OpenSSL.should_receive(:generate_keypair)
      Idkfa::OpenSSL.stub(:write_keypair)
    end

    it 'writes the keypair to disk' do
      Idkfa::OpenSSL.should_receive(:write_keypair)
      Idkfa::OpenSSL.stub(:generate_keypair)
    end
  end

  describe '#keypair_exists?' do
    it "constructs the expected public/private key filenames when no name is passed" do
      File.should_receive(:exists?).with('/tmp/idkfa/.idkfa/default.public.yml').once
      File.should_receive(:exists?).with('/tmp/idkfa/.idkfa/.default.private.yml').once
      Idkfa::OpenSSL.keypair_exists?
    end

    it "constructs the expected public/private key filenames when a custom name is passed" do
      File.should_receive(:exists?).with('/tmp/idkfa/.idkfa/heroku.public.yml').once
      File.should_receive(:exists?).with('/tmp/idkfa/.idkfa/.heroku.private.yml').once
      Idkfa::OpenSSL.keypair_exists? 'heroku'
    end

    it "returns true when files exist" do
      File.stub(:exists?).and_return(true)
      Idkfa::OpenSSL.keypair_exists?.should be_true
    end

    it "returns false when neither file exists" do
      File.stub(:exists?).and_return(false)
      Idkfa::OpenSSL.keypair_exists?.should be_false
    end
  end
end