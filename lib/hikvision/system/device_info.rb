module Hikvision
  class System
    attr_reader :dxml

    def name
      require_dxml
      @dxml.at_xpath('deviceName').inner_html
    end

    def id
      require_dxml
      @dxml.at_xpath('deviceID').inner_html
    end

    def description
      require_dxml
      @dxml.at_xpath('deviceDescription').inner_html
    end

    def location
      require_dxml
      @dxml.at_xpath('deviceLocation').inner_html
    end

    def model
      require_dxml
      @dxml.at_xpath('model').inner_html
    end

    def serial
      require_dxml
      @dxml.at_xpath('serialNumber').inner_html
    end

    def mac_address
      require_dxml
      @dxml.at_xpath('macAddress').inner_html
    end

    def firmware_version
      require_dxml
      @dxml.at_xpath('firmwareVersion').inner_html
    end

    def encoder_version
      require_dxml
      @dxml.at_xpath('encoderVersion').inner_html
    end

    def boot_version
      require_dxml
      @dxml.at_xpath('bootVersion').inner_html
    end

    def hardware_version
      require_dxml
      @dxml.at_xpath('hardwareVersion').inner_html
    end

    def type
      require_dxml
      @dxml.at_xpath('deviceType').inner_html
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
