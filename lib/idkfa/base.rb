require 'yaml'

module Idkfa

  class << self

    def load_keys env = :production, opts = {}
      raise "You must provide :credentials => 'file.yml'" if opts[:credentials].nil?

      yaml = load_yaml opts[:credentials]

      yaml[env.to_s].each_pair do |key, value|
        ENV[key.upcase] = value.to_s
      end
    end

    def load_yaml filename
      YAML.load_file(filename)
    end
    private :load_yaml

  end

end
