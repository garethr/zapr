# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zapr/version'

Gem::Specification.new do |spec|
  spec.name          = "zapr"
  spec.version       = Zapr::VERSION
  spec.authors       = ["Gareth Rushgrove"]
  spec.email         = ["gareth@morethanseven.net"]
  spec.summary       = %q{}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency "owasp_zap", "0.0.95"
  spec.add_dependency "clamp"
  spec.add_dependency "colorize"
  spec.add_dependency "terminal-table"
end
