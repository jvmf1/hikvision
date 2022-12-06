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

    def model
      require_dxml
      @dxml.model.inner_html
    end

    def serial
      require_dxml
      @dxml.serialNumber.inner_html
    end

    def mac_address
      require_dxml
      @dxml.macAddress.inner_html
    end

    def firmware_version
      require_dxml
      @dxml.firmwareVersion.inner_html
    end

    def encoder_version
      require_dxml
      @dxml.encoderVersion.inner_html
    end

    def boot_version
      require_dxml
      @dxml.bootVersion.inner_html
    end

    def hardware_version
      require_dxml
      @dxml.hardwareVersion.inner_html
    end

    def type
      require_dxml
      @dxml.deviceType.inner_html
    end

    def support_beep?
      require_dxml
      @dxml.supportBeep.inner_html == 'true'
    end

    def support_video_loss?
      require_dxml
      @dxml.supportVideoLoss.inner_html == 'true'
    end

    def diagnosed_data(options = {cache: false})
      @isapi.get('/ISAPI/System/diagnosedData', options).response.body
    end

    def load_device_info(options = {})
      @dxml = @isapi.get_xml('/ISAPI/System/deviceInfo', options).DeviceInfo
    end

    private

    def require_dxml
      raise 'load_device_info is required' unless @dxml
    end
  end
end
