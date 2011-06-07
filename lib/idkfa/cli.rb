require 'slop'

module Idkfa
  class CLI
    class << self

      def run
        opts = Slop.parse ARGV.dup do |o|

          o.on :h, :help, do
            puts generic_banner
            exit
          end

          available_commands.each_pair do |cmd, blk|
            o.command cmd, :help => true do |c|
              c.banner "Usage: idkfa #{cmd} [opts]"
              blk[c]
            end
          end

        end

        if cmd = argv_starts_with_valid_command
          send(cmd, opts[cmd])
        else
          puts generic_banner
          exit 1
        end
      end

      def argv_starts_with_valid_command
        ARGV.any? && available_commands.keys.detect {|x| x.to_s == ARGV[0]}
      end

      def available_commands
        {
          :generate => lambda {|c|
            c.on :v
          },
          :encrypt => lambda {|c|},
          :decrypt => lambda {|c|}
        }
      end

      def decrypt opts
        puts 'decrypting'
      end

      def encrypt opts
        puts 'encrypting'
      end

      def generate opts
        puts 'generating'
        puts "v? #{opts.v?}"
      end

      def generic_banner
        <<-HELP_STR
Usage: idkfa COMMAND [opts]

Where COMMAND is one of:
#{available_commands.keys.map{|str| "\t#{str}"}.join("\n")}

See the help for each command by passing the -h option. eg:
\tidkfa generate -h
HELP_STR
      end

    end
  end
end
