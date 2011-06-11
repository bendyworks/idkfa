When /^I run the "init" cli command$/ do
  require 'idkfa/cli'
  Idkfa::CLI.run(['init'])
end

When /^I run the "init" cli command with "-c cred.yml"$/ do
  require 'idkfa/cli'
  Idkfa::CLI.run(['init', '-c', 'cred.yml'])
end
