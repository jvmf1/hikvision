module Hikvision
  class Network
    class Integration < Hikvision::Base
      class << self
        def url
          "/ISAPI/System/Network/Integrate"
        end
      end

      def initialize(isapi)
        @isapi = isapi
      end

      add_xml(:base, url)

      add_setter(:cgi=, :base, '/Integrate/CGI/enable', TrueClass, FalseClass)

      add_getter(:cgi_authentication, :base, '/Integrate/CGI/certificateType') { |v| v.include?("basic") ? :basic : :digest }
      add_setter(:cgi_authentication=, :base, '/Integrate/CGI/certificateType', Symbol) { |v| v == :basic ? "digest/basic" : v.to_s }

      add_bool_getter(:cgi?, :base, '/Integrate/CGI/enable')
      add_bool_getter(:onvif?, :base, '/Integrate/ONVIF/enable')
      add_bool_getter(:isapi?, :base, '/Integrate/ISAPI/enable')

      def update(options = {})
        options[:body] = @base_xml.to_s
  
        @isapi.put_xml(self.class.url, options)
      end
    end
  end
end
