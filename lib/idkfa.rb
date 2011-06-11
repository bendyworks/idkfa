require 'fileutils'
require 'idkfa/open_ssl'

module Idkfa

  class << self

    def project_directory
      File.expand_path '.'
    end

    def home_directory
      File.expand_path '~'
    end

  end

end
