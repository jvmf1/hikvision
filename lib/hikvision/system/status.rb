module Hikvision
  class System
    def uptime(options = { cache: false })
      @isapi.get_xml('/ISAPI/System/status', options).at_xpath('DeviceStatus/deviceUpTime').inner_html.to_i
    end

    add_xml(:status, '/ISAPI/System/status', 'DeviceStatus')

    add_list_getter(:memory_usage, :status, 'MemoryList/Memory/memoryUsage', :to_i)
    add_list_getter(:memory_available, :status, 'MemoryList/Memory/memoryAvailable', :to_i)
    add_list_getter(:memory_description, :status, 'MemoryList/Memory/memoryDescription', :to_s)
    add_list_getter(:cpu_utilization, :status, 'CPUList/CPU/cpuUtilization', :to_i)
    add_list_getter(:cpu_description, :status, 'CPUList/CPU/cpuDescription', :to_s)
  end
end
