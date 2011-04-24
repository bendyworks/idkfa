require 'spec_helper'

describe Idkfa::SymmetricKey do

  describe '.decrypt_with_private_key' do

    let(:ciphertext) { 'ciphertext!' }
    let(:private_key) { 'the private key!' }
    let(:plaintext) { 'plaintext!' }

    it 'decrypts the symmetric key with a private key' do
      opts = {:ciphertext => ciphertext, :private_key => private_key}
      Idkfa::SymmetricKey.decrypt_with_private_key(opts).should == plaintext
    end

  end

end
