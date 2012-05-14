# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "saver/version"

Gem::Specification.new do |s|
  s.name        = "saver"
  s.version     = Saver::VERSION
  s.authors     = ["Christopher Giroir"]
  s.email       = ["kelsin@valefor.com"]
  s.homepage    = "http://kelsin.github.com/saver/"
  s.summary     = %q{Save a string version of columns automatically}
  s.description = %q{Save a string version of columns automatically}

  s.rubyforge_project = "saver"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport', '~> 3.0'
  s.add_dependency 'mongo_mapper'

  s.add_development_dependency 'rspec', '~> 2.6.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'simplecov'
end
