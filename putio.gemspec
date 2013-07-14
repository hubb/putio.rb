# coding: utf-8

require './lib/putio/version'

Gem::Specification.new do |s|
  s.name          = 'putio.rb'
  s.version       = PutIO::VERSION
  s.date          = '2013-06-01'
 
  s.summary       = "Put.io ruby gem"
  s.description   = "putio.rb lets you easily access Put.io API v2"
   
  s.authors       = ["Thibault Gautriaud"]
  s.email         = "thibault.gautriaud@gmail.com"
  s.homepage      = "https://github.com/hubb/putio.rb"
 
  s.require_paths = ["./lib"]
  s.files         = Dir.glob("lib/**/*.rb")
  s.test_files    = Dir.glob("spec/**/*.rb")
  s.executables   = ["putio"]

  s.add_dependency 'thor'
  s.add_dependency 'httparty'
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rspec', '~>2.0'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-nav'

end
