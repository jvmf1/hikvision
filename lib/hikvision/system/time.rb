module Hikvision
  class System
    def time(options = {cache: false})
      Date.parse(@isapi.get_xml('/ISAPI/System/time', options).Time.localTime.inner_html)
    end

    def time_zone(options = {})
      require_txml
      @txml.timeZone.inner_html
    end

    def time_mode(options = {})
      require_txml
      @txml.timeMode.inner_html
    end

    def load_time(options = {})
      @txml = @isapi.get_xml('/ISAPI/System/time', options).Time
    end

    private

    def require_txml
      raise 'load_time is required' unless @txml
    end
  end
end
