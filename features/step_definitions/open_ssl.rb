Given /^RSA key generation is stubbed$/ do
  hash = mock(:to_s => 'private key', :public_key => mock(:to_s => 'public key'))
  ::OpenSSL::PKey::RSA.stub(:generate => hash)
end