# frozen_string_literal: true

module Hikvision
  class System < Hikvision::Base
    attr_reader :network, :time

    def initialize(isapi)
      super()
      @isapi = isapi
      @network = Network.new(isapi)
      @time = Time.new(isapi)
    end

    def hardware
      unless instance_variable_defined?(:@hardware)
        begin
          @hardware = Hardware.new(@isapi)
          @hardware.load_base
        rescue
          @hardware = nil
        end
      end
      @hardware
    end
  end
end
