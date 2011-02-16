# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hackershout/version"

Gem::Specification.new do |s|
  s.name        = "hackershout"
  s.version     = Hackershout::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josep M. Bach", "Josep Jaume Rey", "Oriol Gual"]
  s.email       = ["info@codegram.com"]
  s.homepage    = "http://github.com/codegram/hackershout"
  s.summary     = %q{Shout your hackerness! Promote your work on Reddit, Hackernews and Ruby Flow.}
  s.description = %q{Shout your hackerness! Promote your work on Reddit, Hackernews and Ruby Flow.}

  s.rubyforge_project = "hackershout"

  s.add_runtime_dependency 'nokogiri'
  s.add_runtime_dependency 'mechanize'

  s.add_development_dependency 'rspec', '~> 2.5.0'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency 'vcr'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
