When /^I run the "init" cli command$/ do
  require 'idkfa/cli'
  Idkfa::CLI.run_with_opts(['init'])
end
