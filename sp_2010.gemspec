# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sp_2010/version"

Gem::Specification.new do |s|
  s.name        = "sp_2010"
  s.version     = Sp2010::VERSION
  s.authors     = ["Jonathan Birkholz"]
  s.email       = ["rookieone@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby gem for accessing files on Sharepoint 2010}
  s.description = %q{Ruby gem for accessing files on Sharepoint 2010}

  s.rubyforge_project = "sp_2010"

  s.add_development_dependency "rspec"
  s.add_development_dependency "httparty"
  s.add_development_dependency "json"
  s.add_development_dependency "nokogiri"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
