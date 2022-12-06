require_relative 'lib/hikvision/version'

Gem::Specification.new do |s|
  s.name = 'hikvision'
  s.version = Hikvision::VERSION
  s.summary = 'Ruby Hikvision Interface'
  s.description = s.summary
  s.authors = ['jvmf1']
  s.files = [
    'lib/hikvision.rb',
    'lib/hikvision/version.rb',
    'lib/hikvision/isapi.rb',
    'lib/hikvision/streaming/streaming.rb',
    'lib/hikvision/streaming/channel.rb',
    'lib/hikvision/system/system.rb'
  ]
  s.homepage = 'https://github.com/jvmf1/hikvision'
  s.license = 'MIT'
end
