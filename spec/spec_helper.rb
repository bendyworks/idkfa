require File.expand_path('../../lib/idkfa', __FILE__)
require File.expand_path('../../lib/idkfa/cli', __FILE__)

require 'aruba/api'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.expand_path("../spec/support/**/*.rb", __FILE__)].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.treat_symbols_as_metadata_keys_with_true_values = true

  # TODO: Use Aruba's working directory stuffs - @issue-4
  config.before do
    path = '/tmp/idkfa'
    FileUtils.rm_rf "#{path}/.idkfa"
    ::Idkfa::Idkfa.stub(:home_directory => path)

    FileUtils.rm_rf path
    FileUtils.mkdir_p path
    ::Idkfa::Idkfa.stub(:project_directory => "#{path}/project")

    FileUtils.mkdir_p "#{::Idkfa::Idkfa.project_directory}/config"
  end

end
