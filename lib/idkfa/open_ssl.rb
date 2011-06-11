require 'openssl'

module Idkfa
  class OpenSSL
    class << self
      def generate_keypair
        rsa = ::OpenSSL::PKey::RSA.generate(4096)
        {:public_key => rsa.public_key.to_s, :private_key => rsa.to_s}
      end
    end
  end
end
