#!/usr/bin/env ruby

$:.unshift(File.expand_path('../lib', __FILE__))

require 'idkfa'
require 'idkfa/cli'

without_gen = Idkfa::CLI.run()
with_gen = Idkfa::CLI.run('generate')

require 'ruby-debug'

debugger

x = 1

puts without_gen
puts
puts '=' * 80
puts
puts with_gen
