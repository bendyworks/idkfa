Given /^directories and rsa generation are stubbed$/ do
  Given 'the home directory is stubbed to "/tmp/idkfa"'
  Given 'RSA key generation is stubbed'
  Given 'the project directory is stubbed to "/tmp/idkfa/project"'
end

When /^I run the "keygen" cli command$/ do
  require 'idkfa/cli'
  Idkfa::CLI.run(['keygen'])
end

When /^I run the "keygen" cli command with the "([^"]*)" custom name argument$/ do |keypair_name|
  require 'idkfa/cli'
  Idkfa::CLI.run(['keygen',keypair_name])
end


When /^I run the "init" cli command$/ do
  require 'idkfa/cli'
  Idkfa::CLI.run(['init'])
end

When /^I run the "init" cli command with "([^"]*)"$/ do |args|
  require 'idkfa/cli'
  Idkfa::CLI.run(['init'] + args.split(' '))
end
