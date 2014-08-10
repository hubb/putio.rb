# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'putio/version'

Gem::Specification.new do |s|
  s.name          = 'putio'
  s.version       = Putio::VERSION
  s.date          = '2014-08-07'
  s.summary       = 'A gem to access put.io api'
  s.description   = 'putio-rb is a wrapper around put.io api v2 written in ruby.'
  s.authors       = ['Thibault Gautriaud']
  s.email         = 'thibault.gautriaud@gmail.com'
  s.homepage      = 'https://github.com/hubb/putio.rb'

  s.required_ruby_version = '>= 1.9.3'
  s.require_paths = ['lib']
  s.files         = `git ls-files`.split($/)
  s.test_files    = `git ls-files -- spec/*`.split($/)

  s.add_development_dependency 'bundler'
end
