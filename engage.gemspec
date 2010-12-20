# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "engage/version"

Gem::Specification.new do |s|
  s.name        = "engage"
  s.version     = Engage::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lucas Mazza"]
  s.email       = ["luc4smazza@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Quick setup for your ruby apps}
  s.description = %q{Engage is a CLI for rapid bootstrap for your ruby apps using Git, RVM and Bundler.}

  s.rubyforge_project = "engage"
  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "bundler", "~> 1.0"
  s.add_development_dependency "rspec", "~> 2.3"
  s.add_development_dependency "fakefs"
  s.add_runtime_dependency "thor", "~> 0.14"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
