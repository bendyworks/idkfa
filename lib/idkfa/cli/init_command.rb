require 'slop'

module Idkfa
  module CLI
    class InitCommand

      def initialize opts
        @parsed = Slop.parse opts do |o|
          o.on :c, :config_file, :optional => true
        end
      end

      def run
        create_keypair unless keypair_exists?
        create_credentials_file unless credentials_file_exists?
      end

      def keypair_exists?
        false
      end

      def credentials_file_exists?
        false
      end

      def create_keypair
        keys = Idkfa::OpenSSL.generate_keypair
        Idkfa::OpenSSL.write_keypair 'default', keys
      end

      def create_credentials_file
        filename = determine_credentials_location
        if File.exists?(filename)
          fail 'Cannot init: credentials file already exists'
        else
          hash = {'keys' => [{'id' => 'login@computer', 'public_key' => 'pub_key', 'symmetric_key' => 'sym_key'}]}
          File.open(filename, 'w') do |f|
            YAML.dump(hash, f)
          end
        end
      end

      def determine_credentials_location
        if @parsed.config_file?
          "#{Idkfa.project_directory}/#{@parsed[:config_file]}"
        else
          with_config = "#{Idkfa.project_directory}/config"

          if Dir.exists?(with_config)
            "#{with_config}/credentials.yml"
          else
            "#{Idkfa.project_directory}/credentials.yml"
          end
        end
      end

    end
  end
end

