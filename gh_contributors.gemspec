#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

Kernel.load File.expand_path("../lib/gh_contributors/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name        = "gh_contributors"
  s.version     = GhContributors::VERSION
  s.authors     = ["Michal Papis"]
  s.email       = ["mpapis@gmail.com"]
  s.homepage    = "https://github.com/mpapis/gh_contributors"
  s.summary     = %q{Update static files with github contributors list.}

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  #s.add_development_dependency "smf-gem"
end
