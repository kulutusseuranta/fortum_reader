# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fortum_reader'

Gem::Specification.new do |s|
  s.name = 'fortum_reader'
  s.version = '0.0.3'
  s.date = '2013-05-15'
  s.summary = "Fortum Reader can read readings from Fortum Web site using screen scraping techniques."
  s.description = "Fortum Reader can read readings from Fortum Web site using screen scraping techniques. Credentials needed."
  s.authors = ["kulutusseuranta.fi"]
  s.email = 'support@kulutussseuranta.fi'
  s.files = ["lib/fortum_reader.rb"]
  s.homepage = 'https://github.com/kulutusseuranta/fortum_reader'

  s.require_path = "lib"
  s.required_ruby_version = '>= 1.8.7'
  # Dependencies
  s.add_runtime_dependency('mechanize')
end