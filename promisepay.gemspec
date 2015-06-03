# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'promisepay/version'

Gem::Specification.new do |spec|
  spec.name          = "promisepay"
  spec.version       = Promisepay::VERSION
  spec.authors       = ["Romain Vigo Benia"]
  spec.email         = ["romain.vigobenia@gmail.com"]
  spec.summary       = %q{Gem to wrap promisepay.com API.}
  spec.description   = %q{Gem to wrap promisepay.com API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "yard"

  spec.add_dependency "faraday"
  spec.add_dependency "json"
end
