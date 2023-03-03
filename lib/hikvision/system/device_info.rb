module Hikvision
  class System
    add_xml(:device_info, '/ISAPI/System/deviceInfo')

    add_getter(:name, :device_info, '//deviceName')
    add_getter(:id, :device_info, '//deviceID')
    add_getter(:description, :device_info, '//deviceDescription')
    add_getter(:location, :device_info, '//deviceLocation')
    add_getter(:model, :device_info, '//model')
    add_getter(:serial, :device_info, '//serialNumber')
    add_getter(:mac_address, :device_info, '//macAddress')
    add_getter(:firmware_version, :device_info, '//firmwareVersion')
    add_getter(:encoder_version, :device_info, '//encoderVersion')
    add_getter(:boot_version, :device_info, '//bootVersion')
    add_getter(:hardware_version, :device_info, '//hardwareVersion')
    add_getter(:type, :device_info, '//deviceType')

    add_bool_getter(:support_beep?, :device_info, '/DeviceInfo/supportBeep')
    add_bool_getter(:support_video_loss?, :device_info, '/DeviceInfo/supportVideoLoss')
  end
end
