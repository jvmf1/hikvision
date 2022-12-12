module Hikvision
  class System
    attr_reader :sxml

    def uptime(options = {cache: false})
      @isapi.get_xml('/ISAPI/System/status', options).at_xpath('DeviceStatus/deviceUpTime').inner_html.to_i
    end

    add_list_getter(:memory_usage, :@sxml, 'MemoryList/Memory/memoryUsage', :to_i)
    add_list_getter(:memory_available, :@sxml, 'MemoryList/Memory/memoryAvailable', :to_i)
    add_list_getter(:memory_description, :@sxml, 'MemoryList/Memory/memoryDescription', :to_s)
    add_list_getter(:cpu_utilization, :@sxml, 'CPUList/CPU/cpuUtilization', :to_i)
    add_list_getter(:cpu_description, :@sxml, 'CPUList/CPU/cpuDescription', :to_s)

    def load_status(options = {})
      @sxml = @isapi.get_xml('/ISAPI/System/status', options).at_xpath('DeviceStatus')
    end
  end
end
