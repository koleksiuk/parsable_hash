# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parsable_hash/version'

Gem::Specification.new do |spec|
  spec.name          = "parsable_hash"
  spec.version       = ParsableHash::VERSION
  spec.authors       = ["Konrad Oleksiuk"]
  spec.email         = ["konole@gmail.com"]
  spec.description   = %q{Allows to parse hash with e.g. string values to other class instances}
  spec.summary       = %q{ParsableHash extension for classes}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency 'mime-types', '~> 1.25.1'
end
