step 'directories and rsa generation are stubbed' do
  step 'the home directory is stubbed to "/tmp/idkfa"'
  step 'RSA key generation is stubbed'
  step 'the project directory is stubbed to "/tmp/idkfa/project"'
end

step 'I run the "keygen" cli command' do
  require 'idkfa/cli'
  Idkfa::CLI.run(['keygen'])
end

step 'I run the "keygen" cli command with the :keypair_name custom name argument' do |keypair_name|
  require 'idkfa/cli'
  Idkfa::CLI.run(['keygen',keypair_name])
end


step 'I run the "init" cli command' do
  require 'idkfa/cli'
  Idkfa::CLI.run(['init'])
end

step 'I run the "init" cli command with :args' do |args|
  require 'idkfa/cli'
  Idkfa::CLI.run(['init'] + args.split(' '))
end
