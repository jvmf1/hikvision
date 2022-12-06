module Hikvision
  class System
    def initialize(isapi)
      @isapi = isapi
    end

    def reboot
      @isapi.put('/ISAPI/System/reboot')
    end
  end
end
