module Hikvision
  class System
    add_xml(:status, '/ISAPI/System/status')

    add_getter(:uptime, :status, '//deviceUpTime', { cache: false }, &:to_i)

    add_list_getter(:memory_usage, :status, '//memoryUsage', { cache: false }, &:to_i)
    add_list_getter(:memory_available, :status, '//memoryAvailable', { cache: false }, &:to_i)
    add_list_getter(:memory_description, :status, '//memoryDescription')
    add_list_getter(:cpu_utilization, :status, '//cpuUtilization', { cache: false }, &:to_i)
    add_list_getter(:cpu_description, :status, '//cpuDescription')
  end
end
