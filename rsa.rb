require 'openssl'

pkey = open(File.expand_path('~/.ssh/id_rsa')).read
pubkey = open(File.expand_path('~/.ssh/id_rsa.pub')).read

puts pubkey
pub = OpenSSL::PKey::RSA.new pubkey
ciphertext = pub.private_encrypt 'foo!'

priv = OpenSSL::PKey::RSA.new pkey
plaintext = priv.public_decrypt ciphertext

puts plaintext
