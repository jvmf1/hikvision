module Hikvision
  class System
    attr_reader :txml

    def time(options = { cache: false })
      date = @isapi.get_xml('/ISAPI/System/time', options).at_xpath('Time/localTime').inner_html.to_s
      DateTime.strptime(date, '%Y-%m-%dT%H:%M:%S%z')
    end

    add_xml(:time, '/ISAPI/System/time', 'Time')

    add_getter(:time_zone, :time, 'timeZone', :to_s)
    add_getter(:time_mode, :time, 'timeMode', :to_s)
  end
end
