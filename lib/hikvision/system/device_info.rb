module Hikvision
  class System
    attr_reader :dxml

    add_getter(:name, :@dxml, 'deviceName', :to_s)
    add_getter(:id, :@dxml, 'deviceID', :to_s)
    add_getter(:description, :@dxml, 'deviceDescription', :to_s)
    add_getter(:location, :@dxml, 'deviceLocation', :to_s)
    add_getter(:model, :@dxml, 'model', :to_s)
    add_getter(:serial, :@dxml, 'serialNumber', :to_s)
    add_getter(:mac_address, :@dxml, 'macAddress', :to_s)
    add_getter(:firmware_version, :@dxml, 'firmwareVersion', :to_s)
    add_getter(:encoder_version, :@dxml, 'encoderVersion', :to_s)
    add_getter(:boot_version, :@dxml, 'bootVersion', :to_s)
    add_getter(:hardware_version, :@dxml, 'hardwareVersion', :to_s)
    add_getter(:type, :@dxml, 'deviceType', :to_s)

    add_bool_getter(:support_beep?, :@dxml, 'supportBeep')
    add_bool_getter(:support_video_loss?, :@dxml, 'supportVideoLoss')

    def load_device_info(options = {})
      @dxml = @isapi.get_xml('/ISAPI/System/deviceInfo', options).at_xpath('DeviceInfo')
    end
  end
end
