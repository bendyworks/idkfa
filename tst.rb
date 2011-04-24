require 'openssl'
require 'base64'

key = 'some secret key aflgha4rt9824rjkbefkljaherhwrhwufhoapuwehfa'
iv = 'the ivpoahergophwerohwehroh'

aes = OpenSSL::Cipher.new 'AES-256-CBC'
aes.encrypt
rnd = aes.random_key
rndarr = []
rnd.bytes {|x| rndarr << ("%02x" % x)}
puts rndarr.join
aes.iv = iv
res = aes.update('foo!') + aes.final

puts Base64.strict_encode64(res)


dec = OpenSSL::Cipher.new 'AES-256-CBC'
dec.decrypt
dec.key = rnd
dec.iv = iv
res2 = dec.update(res) + dec.final

puts res2
