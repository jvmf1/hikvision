module Hikvision
  class System
    def diagnosed_data(options = { cache: false })
      @isapi.get('/ISAPI/System/diagnosedData', options).response.body
    end
  end
end
