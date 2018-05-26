
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "moka/version"

Gem::Specification.new do |spec|
  spec.name          = "moka-payment"
  spec.version       = Moka::VERSION
  spec.authors       = ["Farhad"]
  spec.email         = ["farhad9801@gmail.com"]

  spec.summary       = %q{Ruby gem for Moka payment system}
  # spec.description   = %q{}
  spec.homepage      = "https://github.com/0x2C6/moka-payment"
  spec.license       = "MIT"

  # # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'rest-client', '~> 2.0', '>= 2.0.2'
  spec.add_development_dependency 'json', '~> 2.1'
  spec.add_development_dependency 'minitest-hooks', '~> 1.5'
end
