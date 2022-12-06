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
  end
end
