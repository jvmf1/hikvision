module Hikvision
  class System
    def uptime(options = { cache: false })
      @isapi.get_xml('/ISAPI/System/status', options).at_xpath('DeviceStatus/deviceUpTime').inner_html.to_i
    end

    add_xml(:status, '/ISAPI/System/status', 'DeviceStatus')

    add_list_getter(:memory_usage, :status, 'MemoryList/Memory/memoryUsage') { |v| v.to_i }
    add_list_getter(:memory_available, :status, 'MemoryList/Memory/memoryAvailable') { |v| v.to_i }
    add_list_getter(:memory_description, :status, 'MemoryList/Memory/memoryDescription')
    add_list_getter(:cpu_utilization, :status, 'CPUList/CPU/cpuUtilization') { |v| v.to_i }
    add_list_getter(:cpu_description, :status, 'CPUList/CPU/cpuDescription')
  end
end
