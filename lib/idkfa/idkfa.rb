require 'fileutils'
require 'yaml'

require 'idkfa/open_ssl'

module Idkfa
  class Idkfa

    class << self

      # @return [String] Usually just the current working directory
      def project_directory
        @project_directory ||= File.expand_path '.'
      end

      # @return [String] Usually just the user's home directory
      def home_directory
        @home_directory ||= File.expand_path '~'
      end

      # @return [String] Usually just '.idkfa' inside the user's home directory
      def key_directory
        @key_directory ||= File.join home_directory, '.idkfa'
      end

    end

    # The location where the credentials file will be written
    # @return [String]
    attr_accessor :config_file

    # list of authorized keys (ie: users and servers)
    # @return [Array]
    attr_accessor :authorizations

    # The secret, symmetric key used to encrypt "content"
    # @return [Idkfa::OpenSSL::Symmetric] unprintable String representing the symmetric key
    attr_accessor :symmetric_key

    # The encrypted sensitive information
    # @return [String] unprintable String representing the encrypted
    # sensitive information
    attr_accessor :content

    #
    # Generates an empty set of credentials, ready to be written to file
    #
    # Should only be called when you want to start from scratch. If you already
    # have a credentials file, use Idkfa.load
    #
    # @param [String] config_file the path to where the credentials should be saved
    #
    def initialize config_file
      @config_file = config_file
      @authorizations = []
      @symmetric_key = OpenSSL::Symmetric.new
      @content = @symmetric_key.encrypt({}.to_yaml)
    end

    # Saves the credentials to config_file
    def save
    end

  end
end
