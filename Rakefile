require 'bundler'
Bundler::GemHelper.install_tasks

Dir['gem_tasks/**/*.rake'].each {|rake| load rake }

task :default => :spec
task :default => :features
