require File.expand_path('../../lib/idkfa', __FILE__)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.expand_path("../spec/support/**/*.rb", __FILE__)].each {|f| require f}

IDKFA_TEST_MODE = true
SPEC_DIR = File.expand_path('..', __FILE__)

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # config.filter_run :focus => true

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
