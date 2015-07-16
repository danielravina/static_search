# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'static_search/version'

Gem::Specification.new do |spec|
  spec.name          = "static_search"
  spec.version       = StaticSearch::VERSION
  spec.authors       = ["DanielRavina"]
  spec.email         = ["danielravina@gmail.com"]
  spec.summary       = %q{Index your Rails app's static content and search it easily}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency             'nokogiri', '~> 1.6.6.2'
  spec.add_dependency             'httparty', '~> 0.13.3'
  spec.add_dependency             'actionview', '~> 4.2.3'
  spec.add_development_dependency 'activerecord', '~> 4.2.1'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'database_cleaner',  '~> 1.3.0'
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'pry', '~> 0.10.1'
end
