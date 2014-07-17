lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'huck/version'

Gem::Specification.new do |s|
  files           = Dir.glob('**/*').reject { |f| File.directory? f }
  s.name          = 'huck'
  s.version       = Huck::Version
  s.summary       = 'Information sharing framework'
  s.description   = 'Open-ended information sharing framework'
  s.authors       = 'Ryan Uber'
  s.email         = 'ru@ryanuber.com'
  s.files         = files.grep(/^(lib|bin)/)
  s.homepage      = 'https://github.com/ryanuber/huck'
  s.license       = 'MIT'
  s.executables   = files.grep(/^bin/) { |f| File.basename f }
  s.test_files    = files.grep(/^spec/)
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.8'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-mocks'
  s.add_development_dependency 'simplecov'

  s.add_development_dependency 'facter'
  s.add_development_dependency 'ohai'
  s.add_development_dependency 'aws-sdk'
  s.add_development_dependency 'bunny'
end
