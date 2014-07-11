lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloudalogue/version'

Gem::Specification.new do |s|
  files           = Dir.glob('**/*').reject { |f| File.directory? f }
  s.name          = 'cloudalogue'
  s.version       = Cloudalogue::Version
  s.summary       = 'Host information via queue'
  s.description   = 'Get information about hosts using facter and queues'
  s.authors       = 'Ryan Uber'
  s.email         = 'ru@ryanuber.com'
  s.files         = files.grep(/^(lib|bin)/)
  s.homepage      = 'https://github.com/ryanuber/cloudalogue'
  s.license       = 'MIT'
  s.executables   = files.grep(/^bin/) { |f| File.basename f }
  s.test_files    = files.grep(/^spec/)
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.8'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'coveralls'
end
