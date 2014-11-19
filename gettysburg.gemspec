# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gettysburg/version'

Gem::Specification.new do |spec|
  spec.name          = "gettysburg"
  spec.version       = Gettysburg::VERSION
  spec.authors       = ["Jeremy Cronk"]
  spec.email         = ["jcronk@nxtechcorp.com"]
  spec.summary       = %q{ put names and addresses in title case }
  spec.description   = %q{ a basic pseudo-parser that tries to intelligently title-case names and addresses }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
