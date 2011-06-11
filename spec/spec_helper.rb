require File.expand_path('../../lib/idkfa', __FILE__)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.expand_path("../spec/support/**/*.rb", __FILE__)].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  config.before do
    path = '/tmp/idkfa'
    FileUtils.rm_rf "#{path}/.idkfa"
    Idkfa.stub(:home_directory => path)

    FileUtils.rm_rf path
    FileUtils.mkdir_p path
    Idkfa.stub(:project_directory => "#{path}/project")

    FileUtils.mkdir_p "#{Idkfa.project_directory}/config"
  end

end
