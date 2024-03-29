# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gitstats/version"

Gem::Specification.new do |s|
  s.name        = "gitstats"
  s.version     = Gitstats::VERSION
  s.authors     = ["Andrey Koleshko"]
  s.email       = ["ka8725@gmail.com"]
  s.homepage    = "http://ka8725.github.com/gitstats"
  s.summary     = %q{Show git statistics using blame}
  s.description = %q{Show git statistics using blame. More metrics are coming.}

  s.rubyforge_project = "gitstats"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "json"
end
