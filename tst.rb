require 'openssl'
require 'base64'

secret_message = 'foo!'

aes = OpenSSL::Cipher.new 'AES-256-CBC'

aes.encrypt
iv = aes.random_iv  # never EVER use the same IV if you're reusing a key
rnd = aes.random_key

puts "IV size: #{iv.length * 8}"

puts "Key: #{Base64.strict_encode64 rnd}"
puts "IV: #{Base64.strict_encode64 iv}"

res = aes.update(secret_message) + aes.final

puts "Encrypted, base64'ed: #{Base64.strict_encode64(res)}"


dec = OpenSSL::Cipher.new 'AES-256-CBC'
dec.decrypt
dec.key = rnd
dec.iv = iv
res2 = dec.update(res) + dec.final

puts "Decrypted: #{res2}"
