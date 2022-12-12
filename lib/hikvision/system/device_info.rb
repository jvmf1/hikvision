module Hikvision
  class System
    attr_reader :dxml

    # basic getters
    [
      ['name', 'deviceName', 'to_s'],
      ['id', 'deviceID', 'to_s'],
      ['description', 'deviceDescription', 'to_s'],
      ['location', 'deviceLocation', 'to_s'],
      ['model', 'model', 'to_s'],
      ['serial', 'serialNumber', 'to_s'],
      ['mac_address', 'macAddress', 'to_s'],
      ['firmware_version', 'firmwareVersion', 'to_s'],
      ['encoder_version', 'encoderVersion', 'to_s'],
      ['boot_version', 'bootVersion', 'to_s'],
      ['hardware_version', 'hardwareVersion', 'to_s'],
      ['type', 'deviceType', 'to_s'],
    ].each do |method, path, transform|
      define_method method do
        require_dxml
        @dxml.at_xpath(path).inner_html.send(transform)
      end
    end

    def support_beep?
      require_dxml
      @dxml.at_xpath('supportBeep').inner_html == 'true'
    end

    def support_video_loss?
      require_dxml
      @dxml.at_xpath('supportVideoLoss').inner_html == 'true'
    end

    def load_device_info(options = {})
      @dxml = @isapi.get_xml('/ISAPI/System/deviceInfo', options).at_xpath('DeviceInfo')
    end

    private

    def require_dxml
      raise 'load_device_info is required' unless @dxml
    end
  end
end
