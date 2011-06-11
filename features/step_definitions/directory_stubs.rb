Given /^the home directory is stubbed to "\/tmp"$/ do
  FileUtils.rm_rf '/tmp/.idkfa/*'
  Idkfa.stub(:home_directory => '/tmp')
end

Given /^the project directory is stubbed to "\/tmp\/project"$/ do
  FileUtils.mkdir_p '/tmp/project'
  FileUtils.rm_rf '/tmp/project/*'
  Idkfa.stub(:project_directory => '/tmp/project')
end
