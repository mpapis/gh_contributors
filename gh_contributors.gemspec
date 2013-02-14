# -*- encoding: utf-8 -*-

require File.expand_path("../lib/gh_contributors/version.rb", __FILE__)

Gem::Specification.new do |spec|
  spec.name        = "gh_contributors"
  spec.version     = GhContributors::VERSION
  spec.authors     = ["Michal Papis", "Jordon Bedwell", "Erik Michaels-Ober"]
  spec.email       = ["mpapis@gmail.com", "envygeeks@gmail.com", "sferik@gmail.com"]
  spec.homepage    = "https://github.com/mpapis/gh_contributors"
  spec.licenses    = ['MIT']
  spec.summary     = %q{Update static files with github contributors list.}

  spec.files       = `git ls-files`.split("\n")
  spec.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  spec.add_dependency "multi_json", "~> 1.6"
end
