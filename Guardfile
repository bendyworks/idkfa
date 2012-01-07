require 'guard/guard'
require File.expand_path('../doc/guard-github-readme', __FILE__)

group 'doc' do
  guard 'GithubReadme' do
    watch 'README.textile'
  end

  guard 'yard', :port => '8809' do
    watch(%r{lib/.+\.rb})
  end
end

group 'test' do
  guard 'cucumber' do
    watch(%r{^features/.+\.feature$})
    watch(%r{^lib/(.+)\.rb})                              { 'features' }
    watch(%r{^features/support/.+$})                      { 'features' }
    watch(%r{^features/step_definitions/(.+)_steps\.rb$}) do |m|
      Dir[File.join("**/#{m[1]}.feature")][0] ||
      Dir[File.join("**/#{m[1]}/*.feature")] ||
      'features'
    end
  end

  guard 'rspec', :version => 2 do
    watch(%r{^spec/.+_spec\.rb}) { 'spec' }
    watch(%r{^lib/(.+)\.rb})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb') { "spec" }
  end
end
