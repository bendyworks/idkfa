module Idkfa
  class Authorization

    attr_accessor :key_name
    attr_accessor :asymmetric_key
    attr_accessor :encrypted_symmetric_key

    # Creates a new
    def initialize symmetric_key, key_name = nil
      @key_name ||= self.class.key_name_from_system
      @asymmetric_key = OpenSSL::Asymmetric.new
      @encrypted_symmetric_key = @asymmetric_key.encrypt(symmetric_key)
    end

    def self.key_name_from_system
      require 'etc'
      require 'socket'
      "#{Etc.getlogin}@#{Socket.gethostname}"
    end

  end
end
