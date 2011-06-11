Given /^the home directory is stubbed to "([^"]*)"$/ do |path|
  FileUtils.rm_rf "#{path}/.idkfa"
  Idkfa.stub(:home_directory => path)
end

Given /^the project directory is stubbed to "([^"]*)"$/ do |path|
  FileUtils.rm_rf path
  FileUtils.mkdir_p path
  Idkfa.stub(:project_directory => path)
end

Given /^the project directory contains "([^"]*)"$/ do |path|
  FileUtils.mkdir_p "#{Idkfa.project_directory}/#{path}"
end
