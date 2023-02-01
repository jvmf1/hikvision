module Hikvision
  class System
    add_xml(:device_info, '/ISAPI/System/deviceInfo', 'DeviceInfo')

    add_getter(:name, :device_info, 'deviceName', :to_s)
    add_getter(:id, :device_info, 'deviceID', :to_s)
    add_getter(:description, :device_info, 'deviceDescription', :to_s)
    add_getter(:location, :device_info, 'deviceLocation', :to_s)
    add_getter(:model, :device_info, 'model', :to_s)
    add_getter(:serial, :device_info, 'serialNumber', :to_s)
    add_getter(:mac_address, :device_info, 'macAddress', :to_s)
    add_getter(:firmware_version, :device_info, 'firmwareVersion', :to_s)
    add_getter(:encoder_version, :device_info, 'encoderVersion', :to_s)
    add_getter(:boot_version, :device_info, 'bootVersion', :to_s)
    add_getter(:hardware_version, :device_info, 'hardwareVersion', :to_s)
    add_getter(:type, :device_info, 'deviceType', :to_s)

    add_bool_getter(:support_beep?, :device_info, 'supportBeep')
    add_bool_getter(:support_video_loss?, :device_info, 'supportVideoLoss')
  end
end
