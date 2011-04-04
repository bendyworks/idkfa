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
          credentials_tmp.mkpath
          credentials.mkpath
        end
      end

      # Load credentials based on environment
      config = YAML.load_file(credentials)
      config.fetch(Rails.env, {}).each do |key, value|
        ENV[key.upcase] = value.to_s
      end
    end
  end
end
