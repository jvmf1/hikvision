module Hikvision
  class System
    def uptime(options = {cache: false})
      @isapi.get_xml('/ISAPI/System/status', options).DeviceStatus.deviceUpTime.inner_html.to_i
    end
  end
end
