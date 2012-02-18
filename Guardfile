# require 'guard/guard'

group 'doc' do
  guard 'readme-on-github' do
    watch(/readme\.(md|markdown)/i)
  end

  guard 'yard', :port => '8808' do
    watch(%r{lib/.+\.rb})
  end
end

group 'test' do
  guard 'rspec', :version => 2 do
    watch(%r{^spec/.+_spec\.rb}) { 'spec' }
    watch(%r{^lib/(.+)\.rb})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb') { "spec" }
  end
end
