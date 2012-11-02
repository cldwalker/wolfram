# -*- encoding: utf-8 -*-
require 'rubygems' unless Object.const_defined?(:Gem)
require File.dirname(__FILE__) + "/lib/wolfram/version"

Gem::Specification.new do |s|
  s.name        = "wolfram"
  s.version     = Wolfram::VERSION
  s.authors     = ["Gabriel Horner", "Ian White"]
  s.email       = "gabriel.horner@gmail.com"
  s.homepage    = "http://github.com/cldwalker/wolfram"
  s.summary = "Wolfram V2 API client"
  s.description =  "Explore the vast world of computational knowledge available for free via Wolfram's v2 API."
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project = 'tagaholic'
  s.executables = ['wolfram']
  s.files = Dir.glob(%w[{lib,test}/**/*.rb bin/* [A-Z]*.{txt,rdoc,md} ext/**/*.{rb,c} **/deps.rip]) + %w{Rakefile wolfram.gemspec}
  s.files += Dir.glob(['test/fixtures/*.xml'])
  s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt"]
  s.license = 'MIT'

  s.add_dependency 'rake'
  s.add_dependency 'nokogiri', '>= 1.4.3'
  s.add_development_dependency 'rr'
  s.add_development_dependency 'bacon', '>= 1.1.0'
  s.add_development_dependency 'bacon-rr'
  s.add_development_dependency 'bacon-bits'
end
