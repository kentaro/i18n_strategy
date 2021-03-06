# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n_strategy/version'

Gem::Specification.new do |gem|
  gem.name          = "i18n_strategy"
  gem.version       = I18nStrategy::VERSION
  gem.authors       = ["Kentaro Kuribayashi"]
  gem.email         = ["kentarok@gmail.com"]
  gem.description   = %q{Provides a very much simple way to detect and set locale in your Rails application}
  gem.summary       = %q{Provides a very much simple way to detect and set locale in your Rails application}
  gem.homepage      = "https://github.com/kentaro/i18n_strategy"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails', '>= 3.0.0'
  gem.add_dependency 'http_accept_language', '>= 2.0.0pre'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-rails'
end
