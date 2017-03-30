# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/sass/lint/version'

Gem::Specification.new do |spec|
  spec.name          = 'guard-sass-lint'
  spec.version       = Guard::Sass::Lint::VERSION
  spec.authors       = ['Daniel Hanson']
  spec.email         = ['hansondr@gmail.com']

  spec.summary       = 'Guard sass-lint wrapper'
  spec.description   = 'Automatically run sass-lint on your SASS'
  spec.homepage      = 'https://github.com/hansondr/guard-sass-lint'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'guard-compat', '~> 1.2'
  spec.add_dependency 'colorize', '~> 0.8'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
