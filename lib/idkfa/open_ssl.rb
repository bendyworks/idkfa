require 'openssl'
require 'fileutils'

module Idkfa
  class OpenSSL
    class << self

      def create_keypair_unless_exists key_name = nil
        key_name = 'default' if key_name.nil? || key_name == ""

        create_keypair(key_name) unless keypair_exists?(key_name)
      end

      def create_keypair keypair_name
        keys = generate_keypair
        write_keypair keypair_name, keys
      end

      def generate_keypair
        rsa = ::OpenSSL::PKey::RSA.generate(4096)
        {:public_key => rsa.public_key.to_s, :private_key => rsa.to_s}
      end

      def write_keypair keypair_name, keys
        pub_key, priv_key = keys[:public_key], keys[:private_key]

        keypair_dir = create_keypair_directory

        write_key "#{keypair_dir}/#{keypair_name}.public.yml", pub_key
        write_key "#{keypair_dir}/.#{keypair_name}.private.yml", priv_key, :chmod => 0600
      end

      def write_key filename, key, opts = {}
        File.open(filename, 'w') do |f|
          YAML.dump(key, f)
        end
        FileUtils.chmod opts[:chmod], filename if opts[:chmod]
      end

      def create_keypair_directory
        FileUtils.mkdir_p(Idkfa.key_directory).first
      end

      def keypair_exists? keypair_name
        public_keyfile = "#{Idkfa.key_directory}/#{keypair_name}.public.yml"
        private_keyfile = "#{Idkfa.key_directory}/.#{keypair_name}.private.yml"
        pub_key_exists  = File.exists? public_keyfile
        priv_key_exists = File.exists? private_keyfile
        pub_key_exists || priv_key_exists
      end
    end
  end
end
