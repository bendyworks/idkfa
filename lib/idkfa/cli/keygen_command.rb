require 'slop'

module Idkfa
  module CLI
    class KeygenCommand

      def initialize opts = []
        @keypair_name = opts.length > 0 ? opts[0] : 'default'
      end

      def run
        if OpenSSL::Asymmetric.keypair_exists? @keypair_name
          abort "A key pair for '#{@keypair_name}' already exists"
        else
          OpenSSL::Asymmetric.create_keypair @keypair_name
        end
      end

    end
  end
end
