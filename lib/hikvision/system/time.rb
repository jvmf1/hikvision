module Hikvision
  class System
    attr_reader :txml

    add_xml(:time, '/ISAPI/System/time', 'Time')

    add_getter(:time, :time, 'localTime', cache: false) { |v| DateTime.strptime(v, '%Y-%m-%dT%H:%M:%S%z') }
    add_getter(:time_zone, :time, 'timeZone')
    add_getter(:time_mode, :time, 'timeMode')
  end
end
