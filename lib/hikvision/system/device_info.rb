module Hikvision
  class System
    add_xml(:device_info, '/ISAPI/System/deviceInfo')

    add_getter(:name, :device_info, '/DeviceInfo/deviceName')
    add_getter(:id, :device_info, '/DeviceInfo/deviceID')
    add_getter(:description, :device_info, '/DeviceInfo/deviceDescription')
    add_getter(:location, :device_info, '/DeviceInfo/deviceLocation')
    add_getter(:model, :device_info, '/DeviceInfo/model')
    add_getter(:serial, :device_info, '/DeviceInfo/serialNumber')
    add_getter(:mac_address, :device_info, '/DeviceInfo/macAddress')
    add_getter(:firmware_version, :device_info, '/DeviceInfo/firmwareVersion')
    add_getter(:encoder_version, :device_info, '/DeviceInfo/encoderVersion')
    add_getter(:boot_version, :device_info, '/DeviceInfo/bootVersion')
    add_getter(:hardware_version, :device_info, '/DeviceInfo/hardwareVersion')
    add_getter(:type, :device_info, '/DeviceInfo/deviceType')

    add_bool_getter(:support_beep?, :device_info, '/DeviceInfo/supportBeep')
    add_bool_getter(:support_video_loss?, :device_info, '/DeviceInfo/supportVideoLoss')
  end
end
