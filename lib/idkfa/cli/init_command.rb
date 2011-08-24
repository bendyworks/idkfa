require 'slop'

module Idkfa
  module CLI
    class InitCommand

      def initialize opts
        @parsed = Slop.parse opts do |o|
          o.on :c, :config_file, :optional => true
          o.on :k, :key_name, :optional => true
        end
      end

      def run
        idkfa = Idkfa.new(@parsed[:config_file])
        idkfa.authorizations << Authorization.new(idkfa.symmetric_key, @parsed[:key_name])
        idkfa.save
        # OpenSSL::Asymmetric.create_keypair_unless_exists(@parsed[:key_name])
        # create_credentials_file unless credentials_file_exists?
      end

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

      # def determine_credentials_location
        # if @parsed.config_file?
          # "#{Idkfa.project_directory}/#{@parsed[:config_file]}"
        # else
          # with_config = "#{Idkfa.project_directory}/config"

          # if Dir.exists?(with_config)
            # "#{with_config}/credentials.yml"
          # else
            # "#{Idkfa.project_directory}/credentials.yml"
          # end
        # end
      # end

    end
  end
end

