
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "stack_master_json_parameter_store/version"

Gem::Specification.new do |spec|
  spec.name          = "stack_master_json_parameter_store"
  spec.version       = StackMasterJsonParameterStore::VERSION
  spec.authors       = ["Nicola Brisotto"]
  spec.email         = ["nicola@pitchtarget.com"]

  spec.summary       = %q{Parse a json parameter and extract a value with JMESPath.}
  spec.description   = %q{Parse a json parameter and extract a value with JMESPath}
  spec.homepage      = "https://github.com/pitchtarget/stack_master_json_parameter_store"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_dependency "stack_master", "~> 1.4"
  spec.add_dependency "jmespath", "~> 1.4"
  spec.add_dependency "aws-sdk-ssm", "~> 1"
end
