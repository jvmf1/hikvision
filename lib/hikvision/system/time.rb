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

      add_getter(:mode, :base, 'timeMode') { |v| v.to_sym }
      add_setter(:mode=, :base, 'timeMode', Symbol, String)

      add_getter(:now, :base, 'localTime', cache: false) { |v| DateTime.strptime(v, '%Y-%m-%dT%H:%M:%S%Z') }
      add_setter(:now=, :base, 'localTime', DateTime) { |v| v.strftime('%Y-%m-%dT%H:%M:%S%Z') }

      add_getter(:zone, :base, 'timeZone')
      add_setter(:zone=, :base, 'timeZone', String)

      def update(options = {})
        options[:body] = @base_xml.xpath('/').to_s

        @isapi.put(self.class.url, options)
      end
    end
  end
end
