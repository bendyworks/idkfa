require 'openssl'

module Idkfa
  class OpenSSL
    class << self
      def generate_keypair
        rsa = ::OpenSSL::PKey::RSA.generate(4096)
        {:public_key => rsa.public_key.to_s, :private_key => rsa.to_s}
      end

      def write_keypair keypair_name, keys
        pub_key = keys[:public_key]
        priv_key = keys[:private_key]

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
        FileUtils.mkdir_p("#{Idkfa.home_directory}/.idkfa").first
      end

    end
  end
end
