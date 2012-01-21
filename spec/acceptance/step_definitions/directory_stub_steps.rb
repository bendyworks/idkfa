# TODO: Use Aruba's working directory stuffs - @issue-4

step 'the home directory is stubbed to :path' do |path|
  FileUtils.rm_rf "#{path}/.idkfa"
  Idkfa::Idkfa.stub(:home_directory => path)
end

step 'the project directory is stubbed to :path' do |path|
  FileUtils.rm_rf path
  FileUtils.mkdir_p path
  Idkfa::Idkfa.stub(:project_directory => path)
end

step 'the project directory contains :path' do |path|
  FileUtils.mkdir_p "#{Idkfa::Idkfa.project_directory}/#{path}"
end

step 'an .idkfa directory exists at :path with :keypair_name keyfiles' do |path, keypair_name|
  FileUtils.mkdir_p path
  FileUtils.touch "#{path}/#{keypair_name}.public.yml"
  FileUtils.touch "#{path}/.#{keypair_name}.private.yml"
end
