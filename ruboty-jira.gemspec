# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/jira/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruboty-jira'
  spec.version       = Ruboty::Jira::VERSION
  spec.authors       = ['Akira Takahashi']
  spec.email         = ['rike422@gmail.com']

  spec.summary       = 'Ruboty jira client'
  spec.description   = 'Ruboty jira client'
  spec.homepage      = 'https://github.com/rike422/ruboty-jira'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'ruboty'
  spec.add_dependency 'jira-ruby', '~> 1.2.0'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
end
