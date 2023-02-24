module Hikvision
  class System
    add_xml(:status, '/ISAPI/System/status')

    add_getter(:uptime, :status, '/DeviceStatus/deviceUpTime', { cache: false }, &:to_i)

    add_list_getter(:memory_usage, :status, '/DeviceStatus/MemoryList/Memory/memoryUsage', { cache: false }, &:to_i)
    add_list_getter(:memory_available, :status, '/DeviceStatus/MemoryList/Memory/memoryAvailable', { cache: false }, &:to_i)
    add_list_getter(:memory_description, :status, '/DeviceStatus/MemoryList/Memory/memoryDescription')
    add_list_getter(:cpu_utilization, :status, '/DeviceStatus/CPUList/CPU/cpuUtilization', { cache: false }, &:to_i)
    add_list_getter(:cpu_description, :status, '/DeviceStatus/CPUList/CPU/cpuDescription')
  end
end
