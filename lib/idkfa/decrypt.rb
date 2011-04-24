module Idkfa
  class Decrypt
    attr_reader :public_key, :public_key_filename, :private_key_filename
    # technically, private_key should not be exposed

    def initialize opts = {}
      @public_key_filename = opts[:public_key_filename] ||
        File.expand_path('~/.ssh/id_rsa.pub')
      @private_key_filename = opts[:private_key_filename] ||
        File.expand_path('~/.ssh/id_rsa')
    end

    def decrypt ciphertext
      determine_keypair
      sym_key = decrypt_symmetric_key find_encrypted_symmetric_key
      decrypt_ciphertext(:ciphertext => ciphertext, :key => sym_key)
    end

private

    def decrypt_ciphertext opts

    end

    def decrypt_symmetric_key encrypted_symmetric_key

    end

    def find_encrypted_symmetric_key
      
    end

    def determine_keypair
      @public_key = ENV['idkfa_public_key']
      @private_key = ENV['idkfa_private_key']
      if @public_key.nil? || @public_key == '' ||
          @private_key.nil? || @private_key == ''
        set_keypair_from_files
      end
    end

    def set_keypair_from_files
      [:public, :private].each do |key|
        File.open(instance_variable_get("@#{key}_key_filename")) do |f|
          instance_variable_set("@#{key}_key", f.read)
        end
      end
    end

  end
end
