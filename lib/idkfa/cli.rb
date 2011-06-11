require 'yaml'

module Idkfa
  class CLI
    class << self

      def run
        run_with_opts ARGV.dup
      end

      def run_with_opts opts
        case opts[0]
        when 'init'
          run_init opts[1..-1]
        else
          puts 'invalid command'
        end
      end

      def run_init opts
        conditionally_create_keypair opts
        conditionally_create_credentials_file
      end

      def conditionally_create_keypair opts
        # ENSURE keypair doesn't already exist
        keypair_dir = conditionally_create_keypair_directory
        keypair_name = opts[0] || 'default'
        keys = Idkfa::OpenSSL.generate_keypair
        pub_key = keys[:public_key]
        priv_key = keys[:private_key]

        File.open("#{keypair_dir}/#{keypair_name}.public.yml", 'w') do |f|
          YAML.dump(pub_key, f)
        end

        File.open("#{keypair_dir}/.#{keypair_name}.private.yml", 'w') do |f|
          YAML.dump(priv_key, f)
        end

      end

      def conditionally_create_keypair_directory
        FileUtils.mkdir_p("#{Idkfa.home_directory}/.idkfa").first
      end

      def conditionally_create_credentials_file
        # ENSURE credentials file doesn't already exist
        filename = "#{Idkfa.project_directory}/credentials.yml"
        unless File.exists?(filename)
          hash = {'keys' => [{'id' => 'login@computer', 'public_key' => 'pub_key', 'symmetric_key' => 'sym_key'}]}
          File.open(filename, 'w') do |f|
            YAML.dump(hash, f)
          end
        end
      end

    end
  end
end
