module Hikvision
  class System < Hikvision::Base
    attr_reader :network, :time

    def initialize(isapi)
      @isapi = isapi
      @network = Network.new(isapi)
      @time = Time.new(isapi)
    end
  end
end
