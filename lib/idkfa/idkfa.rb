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

  end
end
