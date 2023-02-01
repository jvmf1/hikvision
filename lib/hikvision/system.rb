module Hikvision
  class System < Hikvision::Base
    attr_reader :network

    def initialize(isapi)
      @isapi = isapi
      @network = Network.new(isapi)
    end
  end
end
