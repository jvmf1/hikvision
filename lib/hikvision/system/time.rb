module Hikvision
  class System
    class Time < Hikvision::Base
      class << self
        def url
          '/ISAPI/System/time'
        end
      end

      def initialize(isapi)
        @isapi = isapi
      end

      add_xml(:base, url, 'Time')

      add_getter(:mode, :base, 'timeMode')
      add_getter(:datetime, :base, 'localTime', cache: false) { |v| DateTime.strptime(v, '%Y-%m-%dT%H:%M:%S%z') }
      add_getter(:zone, :base, 'timeZone')
    end
  end
end
