# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "idkfa/version"

Gem::Specification.new do |s|
  s.name        = "idkfa"
  s.version     = Idkfa::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bradley Grzesiak", "Jaymes Waters", "Nick Karpenske"]
  s.email       = %w(brad@bendyworks.com jaymes@bendyworks.com nick@bendyworks.com)
  s.homepage    = "https://github.com/bendyworks/idkfa"
  s.summary     = %q{Simple credentials}
  s.description = %q{Store your site credentials in a secure way}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('slop')

  s.add_development_dependency('aruba')
  s.add_development_dependency('guard')
  s.add_development_dependency('guard-rspec')
  s.add_development_dependency('guard-yard')
  s.add_development_dependency('guard-readme-on-github')
  s.add_development_dependency('rb-fsevent')
  s.add_development_dependency('rspec')
  s.add_development_dependency('turnip')

end
