require 'idkfa/exception/base_exception'

module Idkfa
  module Exception
    class KeyPairExistsException < BaseException
      def initialize keypair_name
        @keypair_name = keypair_name
        super
      end

      def message
        "A key pair for '#{@keypair_name}' already exists"
      end
    end
  end
end
