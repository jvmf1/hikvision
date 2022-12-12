module Hikvision
  class System
    attr_reader :txml

    def time(options = {cache: false})
      date = @isapi.get_xml('/ISAPI/System/time', options).at_xpath('Time/localTime').inner_html.to_s
      DateTime.strptime(date, '%Y-%m-%dT%H:%M:%S%z')
    end

    def time_zone(options = {})
      require_txml
      @txml.at_xpath('timeZone').inner_html
    end

    def time_mode(options = {})
      require_txml
      @txml.at_xpath('timeMode').inner_html
    end

    def load_time(options = {})
      @txml = @isapi.get_xml('/ISAPI/System/time', options).at_xpath('Time')
    end

    private

    def require_txml
      raise 'load_time is required' unless @txml
    end
  end
end
