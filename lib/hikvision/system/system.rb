module Hikvision
  class System
    attr_reader :dxml

    def initialize(isapi)
      @isapi = isapi
    end

    def reboot
      @isapi.put('/ISAPI/System/reboot')
    end

    def name
      require_dxml
      @dxml.deviceName.inner_html
    end

    def id
      require_dxml
      @dxml.deviceID.inner_html
    end

    def description
      require_dxml
      @dxml.deviceDescription.inner_html
    end

    def location
      require_dxml
      @dxml.deviceLocation.inner_html
    end

    def load_device_info
      @dxml = @isapi.get_xml('/ISAPI/System/deviceInfo').DeviceInfo
    end

    private

    def require_dxml
      raise "load_device_info is required" unless @dxml
    end
  end
end
