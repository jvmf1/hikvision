module Hikvision
  class Network < Hikvision::Base
    attr_reader :integration

    def initialize(isapi)
      @isapi = isapi
      @integration = Integration.new(isapi)
    end
  end
end
  