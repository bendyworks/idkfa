require 'openssl'
require 'fileutils'

module Idkfa
  module OpenSSL
    class Asymmetric

      attr_accessor :public_key
      attr_accessor :private_key
      attr_accessor :name

      def initialize name = 'default', keys = nil
        name ||= 'default'
        @name = name

        @public_key, @private_key = (keys || self.class.generate_keys).values_at(:public_key, :private_key)
      end

      def save
        FileUtils.mkdir_p ::Idkfa::Idkfa.key_directory
        File.open(public_key_file, 'w') {|f| f.write YAML.dump @public_key }
        File.open(private_key_file, 'w') {|f| f.write YAML.dump @private_key }
      end

      def private_key_file
        self.class.private_key_file @name
      end

      def public_key_file
        self.class.public_key_file @name
      end

      def encrypt plaintext
        @private_key.public_encrypt(plaintext)
      end

      def decrypt ciphertext
      end

      class << self
        def generate_keys
          fail 'Key generation during tests not allowed' if defined?(IDKFA_TEST_MODE)
          rsa = ::OpenSSL::PKey::RSA.generate(4096)
          {:public_key => rsa.public_key.to_s, :private_key => rsa.to_s}
        end

        def private_key_file name
          ::Idkfa::Idkfa.key_directory.join(".#{name}.private.yml")
        end

        def public_key_file name
          ::Idkfa::Idkfa.key_directory.join("#{name}.public.yml")
        end

        def load name = 'default'
          pub_key = YAML.load_file(public_key_file(name))
          priv_key = YAML.load_file(private_key_file(name))
          new name, :public_key => pub_key, :private_key => priv_key
        end
      end

    end
  end
end
