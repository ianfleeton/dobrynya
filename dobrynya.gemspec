lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dobrynya/version'

Gem::Specification.new do |s|
  s.name         = 'dobrynya'
  s.summary      = 'Backup and restore tool for Zmey'
  s.description  = 'Backs up and restores websites running Zmey using the REST API'
  s.requirements = ['A website running Zmey']
  s.version      = Dobrynya::VERSION
  s.licenses     = ['MIT']
  s.author       = 'Ian Fleeton'
  s.email        = 'ianf@yesl.co.uk'
  s.homepage     = 'https://github.com/ianfleeton/dobrynya'
  s.platform     = Gem::Platform::RUBY
  s.files        = Dir['**/**']
  s.executables  = ['dobrynya']
  s.require_paths = ['lib']
  s.test_files   = Dir['spec/*_spec.rb']
  s.has_rdoc     = false
end
