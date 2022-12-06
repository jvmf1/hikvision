module Hikvision
  class System
    attr_reader :dxml, :txml

    def initialize(isapi)
      @isapi = isapi
    end

    def load_device_info(options = {})
      @dxml = @isapi.get_xml('/ISAPI/System/deviceInfo', options).DeviceInfo
    end

    def load_time(options = {})
      @txml = @isapi.get_xml('/ISAPI/System/time', options).Time
    end

    private

    def require_dxml
      raise 'load_device_info is required' unless @dxml
    end

    def require_txml
      raise 'load_time is required' unless @txml
    end
  end
end
