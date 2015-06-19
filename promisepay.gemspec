# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'promisepay/version'

Gem::Specification.new do |spec|
  spec.name          = 'promisepay'
  spec.version       = Promisepay::VERSION
  spec.authors       = ['Romain Vigo Benia']
  spec.email         = ['romain.vigobenia@gmail.com']
  spec.summary       = 'Gem to wrap promisepay.com API.'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/PromisePay/promisepay-ruby'
  spec.license       = 'MIT'

  spec.files         = %w(LICENSE.txt README.md Rakefile promisepay.gemspec)
  spec.files        += Dir.glob('lib/**/*')
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency 'faraday'
  spec.add_dependency 'json'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
