require 'time'

module Hikvision
  class System
    class Time < Hikvision::Base
      attr_reader :ntp

      class << self
        def url
          '/ISAPI/System/time'
        end
      end

      def initialize(isapi)
        @isapi = isapi
        @ntp = Ntp.new(isapi)
      end

      add_xml(:base, url)

      add_getter(:mode, :base, '/Time/timeMode', &:to_sym)
      add_setter(:mode=, :base, '/Time/timeMode', Symbol, String)

      add_getter(:now, :base, '/Time/localTime', cache: false) { |v| Object::Time.strptime(v, '%Y-%m-%dT%H:%M:%S%Z') }
      add_setter(:now=, :base, '/Time/localTime', Object::Time) { |v| v.strftime('%Y-%m-%dT%H:%M:%S%Z') }

      add_getter(:zone, :base, '/Time/timeZone')
      add_setter(:zone=, :base, '/Time/timeZone', String)

      def update(options = {})
        options[:body] = @base_xml.to_s

        @isapi.put_xml(self.class.url, options)
      end
    end
  end
end
