require 'slop'

module Idkfa
  module CLI
    class InitCommand

      attr_accessor :config_file
      attr_accessor :key_name

      def initialize opts
        parsed = Slop.parse opts do |o|
          o.on :c, :config_file, :optional => true
          o.on :k, :key_name, :optional => true
        end
        @config_file = parsed[:config_file] || default_credentials_file
        @key_name = parsed[:key_name]
      end

      def run
        Idkfa.new(@config_file).tap do |idkfa|
          idkfa.authorizations << Authorization.new(idkfa.symmetric_key, @key_name)
          idkfa.save
        end
      end

        # OpenSSL::Asymmetric.create_keypair_unless_exists(@parsed[:key_name])
        # create_credentials_file unless credentials_file_exists?

      # def credentials_file_exists?
        # false
      # end

      # def create_credentials_file
        # filename = determine_credentials_location
        # fail 'Cannot init: credentials file already exists' if File.exists?(filename)

        # hash = {
          # 'keys' => [{'id' => 'login@computer', 'public_key' => 'pub_key', 'symmetric_key' => 'sym_key'}],
          # 'content' => 'abc123'
        # }
        # File.open(filename, 'w') do |f|
          # YAML.dump(hash, f)
        # end
      # end

      def default_credentials_file
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

