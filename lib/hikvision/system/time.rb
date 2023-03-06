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

      add_getter(:mode, :base, '//timeMode', &:to_sym)
      add_setter(:mode=, :base, '//timeMode', Symbol, String)

      add_getter(:now, :base, '//localTime', cache: false) { |v| Object::Time.strptime(v, '%Y-%m-%dT%H:%M:%S%Z') }
      add_setter(:now=, :base, '//localTime', Object::Time) { |v| v.strftime('%Y-%m-%dT%H:%M:%S%Z') }

      add_getter(:zone, :base, '//timeZone')
      add_setter(:zone=, :base, '//timeZone', String)
    end
  end
end
