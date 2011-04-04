# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "idkfa/version"

Gem::Specification.new do |s|
  s.name        = "idkfa"
  s.version     = Idkfa::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bendyworks"]
  s.email       = ["dev@bendyworks.com"]
  s.homepage    = "http://github.com/bendyworks/idkfa"
  s.summary     = %q{Generate and/or load config/credentials.yml}
  s.description = %q{Use this gem to store your site credentials in a secure way}

  s.rubyforge_project = "idkfa"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("railties", "~> 3.0.0")
end
