require 'fileutils'
require 'yaml'

require 'idkfa/open_ssl'

module Idkfa
  class Idkfa

    class << self

      def project_directory
        @project_directory ||= File.expand_path '.'
      end

      def home_directory
        @home_directory ||= File.expand_path '~'
      end

      def key_directory
        @key_directory ||= File.join home_directory, '.idkfa'
      end

    end

    attr_accessor :config_file

    attr_accessor :authorizations

    # Generates an empty set of credentials, ready to be written to file
    #
    # Should only be called when you want to start from scratch. If you already
    # have a credentials file, use Idkfa.load
    #
    # == Parameters:
    # config_file::
    #   A String with the path to where the credentials should be saved
    #
    def initialize config_file
      @config_file = config_file
      @authorizations = []
    end

    # Saves the credentials to `@config_file`
    def save

    end

  end
end
