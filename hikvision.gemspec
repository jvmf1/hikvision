require_relative 'lib/hikvision/version'

Gem::Specification.new do |s|
  s.name = 'hikvision'
  s.bindir = 'exe'
  s.executables << 'hikvision'
  s.version = Hikvision::VERSION
  s.summary = 'Ruby Hikvision Interface'
  s.authors = ['jvmf1']
  s.files = Dir['{exe,lib}/**/*.rb']
  s.homepage = 'https://github.com/jvmf1/hikvision'
  s.license = 'MIT'

  s.add_dependency 'httparty', '~> 0.21'
  s.add_dependency 'nokogiri', '~> 1.14'
  s.add_dependency 'gli', '~> 2.21'
end
