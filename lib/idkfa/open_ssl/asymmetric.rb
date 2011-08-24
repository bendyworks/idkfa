require 'openssl'
require 'fileutils'

module Idkfa
  module OpenSSL
    class Asymmetric

      attr_accessor :public_key
      attr_accessor :private_key

      def initialize name = 'default'
        @public_key, @private_key = self.class.generate_keys.values_at(:public_key, :private_key)
      end

      def encrypt content
      end

      class << self
        def generate_keys
          rsa = ::OpenSSL::PKey::RSA.generate(4096)
          {:public_key => rsa.public_key.to_s, :private_key => rsa.to_s}
        end
      end

    end
  end
end
