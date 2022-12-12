module Hikvision
  class System < Hikvision::Base
    def initialize(isapi)
      @isapi = isapi
    end
  end
end
