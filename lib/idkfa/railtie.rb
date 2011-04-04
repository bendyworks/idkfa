require 'yaml'

module Idkfa
  class Railtie < Rails::Railtie
    initializer "idkfa.load_credentials" do
      credentials = Rails.root.join 'config/credentials.yml'
      credentials_tmp = Rails.root.join 'config/credentials.yml.template'

      # Copy or create credentials file
      unless credentials.exist?
        if credentials_tmp.exist?
          FileUtils.cp credentials_tmp, credentials
        else
          template =
<<TMP
development:
test:
staging:
production:
TMP
          credentials_tmp.open('w') {|cr| cr.write template }
          credentials.open('w') {|cr| cr.write template }
        end
      end

      # Load credentials based on environment
      config = YAML.load_file(credentials)
      config_vars = config.fetch(Rails.env, {}) || {}
      config_vars.each do |key, value|
        ENV[key.upcase] = value.to_s
      end
    end
  end
end
