require 'yaml'
require 'idkfa/cli/commands'

module Idkfa
  module CLI
    class << self

      def run opts = []
        case opts[0]
        when 'init'
          InitCommand.new(opts[1..-1]).run
        else
          puts 'invalid command'
        end
      end

    end
  end
end
