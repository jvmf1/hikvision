module Hikvision
  class System
    attr_reader :txml

    def time(options = {cache: false})
      date = @isapi.get_xml('/ISAPI/System/time', options).at_xpath('Time/localTime').inner_html.to_s
      DateTime.strptime(date, '%Y-%m-%dT%H:%M:%S%z')
    end

    add_getter(:time_zone, :@txml, 'timeZone', :to_s)
    add_getter(:time_mode, :@txml, 'timeMode', :to_s)

    def load_time(options = {})
      @txml = @isapi.get_xml('/ISAPI/System/time', options).at_xpath('Time')
    end
  end
end
