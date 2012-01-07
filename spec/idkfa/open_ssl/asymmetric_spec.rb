require 'spec_helper'
require 'base64'
require 'idkfa/open_ssl/asymmetric'

describe Idkfa::OpenSSL::Asymmetric do
  let(:home_dir) { '/tmp/idkfa/.idkfa' }
  let(:pub_key) { 'foo' }
  let(:priv_key) { 'bar' }
  let(:keys) { {:public_key => pub_key, :private_key => priv_key} }
  let(:cust_keys) { {:public_key => 'a', :private_key => 'b'} }

  shared_examples_for 'Asymmetric from scratch' do
    before do
      Idkfa::OpenSSL::Asymmetric.stub :generate_keys => keys
    end
    it 'creates a public/private keypair' do
      asym = Idkfa::OpenSSL::Asymmetric.new
      asym.public_key.should == pub_key
      asym.private_key.should == priv_key
    end
    it 'sets name to "default" by default' do
      asym = Idkfa::OpenSSL::Asymmetric.new
      asym.name.should == 'default'
    end
    it 'allows custom names' do
      asym = Idkfa::OpenSSL::Asymmetric.new('cust')
      asym.name.should == 'cust'
    end
  end

  describe '#initialize' do
    context 'when passed zero or one args' do
      it_should_behave_like 'Asymmetric from scratch'
    end
    context 'when passed the key args' do
      it 'stores uses the passed keys' do
        asym = Idkfa::OpenSSL::Asymmetric.new(nil, cust_keys)
        asym.public_key.should == cust_keys[:public_key]
        asym.private_key.should == cust_keys[:private_key]
      end
    end
  end

  describe '#initialize_from_scratch' do
    it_should_behave_like 'Asymmetric from scratch'
  end

  describe '#save', :focus => true do
    let(:asym) { Idkfa::OpenSSL::Asymmetric.new }
    let(:public_path) { Idkfa::Idkfa.key_directory.join("#{asym.name}.public.yml") }
    let(:private_path) { Idkfa::Idkfa.key_directory.join(".#{asym.name}.private.yml") }
    before do
      Idkfa::OpenSSL::Asymmetric.stub :generate_keys => keys
      asym.save
    end

    it 'saves the asymmetric public key' do
      YAML.load_file(public_path).should == 'foo'
    end
    it 'saves the asymmetric private key' do
      YAML.load_file(private_path).should == 'bar'
    end
  end

  describe '.load' do
    before do
      Idkfa::OpenSSL::Asymmetric.stub :generate_keys => keys
      Idkfa::OpenSSL::Asymmetric.new.save
    end
    it 'loads the public key via name' do
      Idkfa::OpenSSL::Asymmetric.load('default').public_key.should == pub_key
    end

    it 'loads the private key via name' do
      Idkfa::OpenSSL::Asymmetric.load('default').private_key.should == priv_key
    end
  end

  describe 'encryption' do
    let(:key_dir) { File.join SPEC_DIR, 'fixtures', 'key_dir' }
    let(:priv_key) { ::OpenSSL::PKey::RSA.new File.read(File.join key_dir, 'priv_key.pem') }
    let(:pub_key) { ::OpenSSL::PKey::RSA.new priv_key.public_key }
    let(:keys) { {:private_key => priv_key} }

    describe '#encrypt' do
      it 'encrypts the parameter with the public key and returns the result' do
        asym = Idkfa::OpenSSL::Asymmetric.new('default', keys)
        asym.encrypt('foo').length.should == 512 #encrypts differently every time. actually test encryption in #decrypt
      end
    end

    describe '#decrypt' do
      it 'decrypts the parameter with the private key and returns the result'
    end
  end

  # describe "#write_keypair" do

  #   subject { Idkfa::OpenSSL::Asymmetric }
  #   it "creates a keypair directory" do
  #     subject.stub(:write_key)
  #     subject.should_receive(:create_keypair_directory).and_return(home_dir)
  #     Idkfa::OpenSSL::Asymmetric.write_keypair 'default', keys
  #   end

  #   it "writes the public key to disk" do
  #     subject.stub(:write_key)
  #     subject.should_receive(:write_key).with("#{home_dir}/default.public.yml", pub_key)
  #     Idkfa::OpenSSL::Asymmetric.write_keypair 'default', keys
  #   end

  #   it "writes the private key to disk" do
  #     subject.stub(:write_key)
  #     subject.should_receive(:write_key).with("#{home_dir}/.default.private.yml", priv_key, :chmod => 0600)
  #     Idkfa::OpenSSL::Asymmetric.write_keypair 'default', keys
  #   end
  # end

  # describe '#write_key' do
  #   let(:filename) { "#{home_dir}/.default.private.yml" }
  #   before { FileUtils.mkdir_p home_dir }

  #   context 'passed a :chmod in opts' do
  #     it 'chmods the file' do
  #       FileUtils.should_receive(:chmod).with(0600, filename)
  #       Idkfa::OpenSSL::Asymmetric.write_key filename, priv_key, :chmod => 0600
  #     end
  #   end

  #   context 'no passed opts' do
  #     it 'does not chmod the file' do
  #       FileUtils.should_not_receive(:chmod)
  #       Idkfa::OpenSSL::Asymmetric.write_key filename, priv_key
  #     end
  #   end
  # end

  # describe '#create_keypair' do
  #   after { Idkfa::OpenSSL::Asymmetric.create_keypair 'default' }

  #   it 'generates the keypair' do
  #     Idkfa::OpenSSL::Asymmetric.should_receive(:generate_keypair)
  #     Idkfa::OpenSSL::Asymmetric.stub(:write_keypair)
  #   end

  #   it 'writes the keypair to disk' do
  #     Idkfa::OpenSSL::Asymmetric.should_receive(:write_keypair)
  #     Idkfa::OpenSSL::Asymmetric.stub(:generate_keypair)
  #   end
  # end

  # describe '#keypair_exists?' do
  #   it "constructs the expected public/private key filenames when no name is passed" do
  #     File.should_receive(:exists?).with('/tmp/idkfa/.idkfa/default.public.yml').once
  #     File.should_receive(:exists?).with('/tmp/idkfa/.idkfa/.default.private.yml').once
  #     Idkfa::OpenSSL::Asymmetric.keypair_exists? 'default'
  #   end

  #   it "constructs the expected public/private key filenames when a custom name is passed" do
  #     File.should_receive(:exists?).with('/tmp/idkfa/.idkfa/heroku.public.yml').once
  #     File.should_receive(:exists?).with('/tmp/idkfa/.idkfa/.heroku.private.yml').once
  #     Idkfa::OpenSSL::Asymmetric.keypair_exists? 'heroku'
  #   end

  #   it "returns true when files exist" do
  #     File.stub(:exists?).and_return(true)
  #     Idkfa::OpenSSL::Asymmetric.keypair_exists?('default').should be_true
  #   end

  #   it "returns false when neither file exists" do
  #     File.stub(:exists?).and_return(false)
  #     Idkfa::OpenSSL::Asymmetric.keypair_exists?('default').should be_false
  #   end
  # end
end
