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

When /^I run the "init" cli command with "-c cred.yml"$/ do
  require 'idkfa/cli'
  Idkfa::CLI.run(['init', '-c', 'cred.yml'])
end
