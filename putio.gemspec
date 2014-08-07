# coding: utf-8

require File.expand_path('../lib/Putio/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'putio-rb'
  s.version       = Putio::VERSION
  s.date          = '2014-08-07'
  s.summary       = 'A gem to access put.io api'
  s.description   = 'putio-rb is a wrapper around put.io api v2 written in ruby.'
  s.authors       = ['Thibault Gautriaud']
  s.email         = 'thibault.gautriaud@gmail.com'
  s.homepage      = 'https://github.com/hubb/Putio.rb'

  s.required_ruby_version = '>= 1.9.3'
  s.require_paths = ['lib']
  s.files         = `git ls-files`.split($/)
  s.test_files    = `git ls-files -- spec/*`.split($/)

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-nav'
end
