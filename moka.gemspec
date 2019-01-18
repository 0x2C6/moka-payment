
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "moka/version"

Gem::Specification.new do |spec|
  spec.name          = "moka-payment"
  spec.version       = Moka::VERSION
  spec.authors       = ["Farhad"]
  spec.email         = ["farhad9801@gmail.com"]

  spec.summary       = %q{Ruby gem for Moka payment system}
  spec.homepage      = "https://github.com/0x2C6/moka-payment"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency 'rest-client', '~> 2.0', '>= 2.0.2'
  spec.add_dependency 'json', '~> 2.1'
end
