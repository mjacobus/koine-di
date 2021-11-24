# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'koine/di/version'

Gem::Specification.new do |spec|
  spec.name          = 'koine-di'
  spec.version       = Koine::Di::VERSION
  spec.authors       = ['Marcelo Jacobus']
  spec.email         = ['marcelo.jacobus@gmail.com']

  spec.summary       = 'Koine DI, for your dependency injection'
  spec.description   = 'Koine DI, for your dependency injection. Dependency injection container'
  spec.homepage      = 'https://github.com/mjacobus/koine-di'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    fail 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'scrutinizer-ocular'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'simplecov'
end
