# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails/etcs/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails-etcs'
  spec.version       = Rails::Etcs::VERSION
  spec.authors       = ['Jan Graichen']
  spec.email         = ['jgraichen@altimos.de']

  spec.summary       = 'Collection of patches and alternatives for Rails core classes'
  spec.description   = 'Collection of patches and alternatives for Rails core classes'
  spec.homepage      = 'https://github.com/jgraichen/rails-etcs'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'xdg', '~> 2.2', '>= 2.2.3'
  spec.add_dependency 'railties', '>= 4.2.0'

  spec.add_development_dependency 'bundler', '~> 1.13'
end
