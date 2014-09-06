# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twoctwop/version'

Gem::Specification.new do |spec|
  spec.name          = "twoctwop"
  spec.version       = Twoctwop::VERSION
  spec.authors       = ["Zack Siri"]
  spec.email         = ["zack@codemy.net"]
  spec.summary       = %q{Ruby wrapper for 2c2p}
  spec.description   = %q{This gem allows you to interface with 2c2p paymen gateway}
  spec.homepage      = "http://www.codemy.net"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  spec.add_dependency "rest-client", "~> 1.7"
  spec.add_dependency "hashie", "~> 3.3"
  spec.add_dependency "builder", "~> 3.2"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
