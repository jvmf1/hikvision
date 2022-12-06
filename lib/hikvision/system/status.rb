module Hikvision
  class System
    attr_reader :sxml

    def uptime(options = {cache: false})
      @isapi.get_xml('/ISAPI/System/status', options).DeviceStatus.deviceUpTime.inner_html.to_i
    end

    def memory_usage
      require_sxml
      @sxml.MemoryList.xpath('//Memory').map { |m| m.memoryUsage.inner_html.to_i }
    end

    def memory_available
      require_sxml
      @sxml.MemoryList.xpath('//Memory').map { |m| m.memoryAvailable.inner_html.to_i }
    end

    def memory_description
      require_sxml
      @sxml.MemoryList.xpath('//Memory').map { |m| m.memoryDescription.inner_html }
    end

    def cpu_utilization
      require_sxml
      @sxml.CPUList.xpath('//CPU').map { |c| c.cpuUtilization.inner_html.to_i }
    end

    def cpu_description
      require_sxml
      @sxml.CPUList.xpath('//CPU').map { |c| c.cpuDescription.inner_html }
    end

    def load_status(options = {})
      @sxml = @isapi.get_xml('/ISAPI/System/status', options).DeviceStatus
    end

    private

    def require_sxml
      raise "load_status is required" unless @sxml
    end
  end
end
