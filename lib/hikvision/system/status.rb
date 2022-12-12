module Hikvision
  class System
    attr_reader :sxml

    def uptime(options = {cache: false})
      @isapi.get_xml('/ISAPI/System/status', options).at_xpath('DeviceStatus/deviceUpTime').inner_html.to_i
    end

    def memory_usage
      @sxml.xpath('MemoryList/Memory/memoryUsage').map { |m| m.inner_html.to_i }
    end

    def memory_available
      @sxml.xpath('MemoryList/Memory/memoryAvailable').map { |m| m.inner_html.to_i }
    end

    def memory_description
      @sxml.xpath('MemoryList/Memory/memoryDescription').map { |m| m.inner_html }
    end

    def cpu_utilization
      @sxml.xpath('CPUList/CPU/cpuUtilization').map { |c| c.inner_html.to_i }
    end

    def cpu_description
      @sxml.xpath('CPUList/CPU/cpuDescription').map { |c| c.inner_html }
    end

    def load_status(options = {})
      @sxml = @isapi.get_xml('/ISAPI/System/status', options).at_xpath('DeviceStatus')
    end
  end
end
