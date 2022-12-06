module Hikvision
  class System
    attr_reader :dxml, :txml

    def initialize(isapi)
      @isapi = isapi
    end
  end
end
