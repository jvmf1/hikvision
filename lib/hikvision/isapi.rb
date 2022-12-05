require 'httparty'
require 'nokogiri'

module Hikvision
  class ISAPI
    include HTTParty

    attr_accessor :cache
    attr_reader :streaming

    def initialize(ip, username, password, auth = 'digest_auth', https = false)
      @cache = {}
      @auth_type = auth
      @base_uri = "http#{https ? 's' : ''}://#{ip}"
      @auth = { username: username, password: password }
      @streaming = Hikvision::Streaming.new(self)
    end

    def get(path, options = {})
      options = default_request_options.merge(options)
      if @cache.has_key?(path) and options.fetch(:cache, true)
        @cache[path]
      else
        @cache[path] = self.class.get(@base_uri + path, options)
      end
    end

    def get_xml(path, options = {})
      data = get(path, options)
      raise "could not get xml of #{path} code:#{data.response.code}" unless ['200'].include?(data.response.code)

      Nokogiri::Slop(data.body).remove_namespaces!
    end

    def put(path, options = {})
      @cache.delete(path)
      options = default_request_options.merge(options)
      self.class.put(@base_uri + path, options)
    end

    private

    def default_request_options
      {
        "#{@auth_type}": @auth
      }
    end
  end
end
