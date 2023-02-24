module Hikvision
  class System
    class Time
      class Ntp < Hikvision::Base
        class << self
          def url
            '/ISAPI/System/time/ntpServers'
          end
        end

        def initialize(isapi)
          @isapi = isapi
        end

        add_xml(:base, url)

        add_getter(:host, :base, '/NTPServerList/NTPServer/hostName')
        add_setter(:host=, :base, '/NTPServerList/NTPServer/hostName', String)
        
        add_getter(:sync_interval, :base, '/NTPServerList/NTPServer/synchronizeInterval', &:to_i)
        add_setter(:sync_interval=, :base, '/NTPServerList/NTPServer/synchronizeInterval', Integer)

        add_getter(:port, :base, '/NTPServerList/NTPServer/portNo', &:to_i)
        add_setter(:port=, :base, '/NTPServerList/NTPServer/portNo', Integer)

        def update(options = {})
          options[:body] = @base_xml.to_s

          @isapi.put_xml(self.class.url, options)
        end
      end
    end
  end
end
