module Hikvision
  class System
    attr_reader :sxml

    def uptime(options = {cache: false})
      @isapi.get_xml('/ISAPI/System/status', options).at_xpath('DeviceStatus/deviceUpTime').inner_html.to_i
    end

    def memory_usage
      require_sxml
      @sxml.xpath('MemoryList/Memory/memoryUsage').map { |m| m.inner_html.to_i }
    end

    def memory_available
      require_sxml
      @sxml.xpath('MemoryList/Memory/memoryAvailable').map { |m| m.inner_html.to_i }
    end

    def memory_description
      require_sxml
      @sxml.xpath('MemoryList/Memory/memoryDescription').map { |m| m.inner_html }
    end

    def cpu_utilization
      require_sxml
      @sxml.xpath('CPUList/CPU/cpuUtilization').map { |c| c.inner_html.to_i }
    end

    def cpu_description
      require_sxml
      @sxml.xpath('CPUList/CPU/cpuDescription').map { |c| c.inner_html }
    end

    def load_status(options = {})
      @sxml = @isapi.get_xml('/ISAPI/System/status', options).at_xpath('DeviceStatus')
    end

    private

    def require_sxml
      raise "load_status is required" unless @sxml
    end
  end
end
