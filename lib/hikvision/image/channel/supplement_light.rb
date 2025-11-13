# frozen_string_literal: true

module Hikvision
  class Image
    class Channel
      class SupplementLight < Hikvision::Base
        def initialize(isapi, channel)
          super()
          @isapi = isapi
          @channel = channel
        end

        add_xml(:base, -> { url })

        add_getter(:mode, :base, "supplementLightMode")
        add_setter(:mode=, :base, "supplementLightMode", String)
        add_opt_getter(:mode_opts, :capabilities, "SupplementLight/supplementLightMode")

        add_getter(:ir_light_brightness, :base, "irLightBrightness", &:to_i)
        add_setter(:ir_light_brightness=, :base, "irLightBrightness", Integer)
        add_opt_range_getter(:ir_light_brightness_opts, :capabilities, "SupplementLight/irLightBrightness")

        add_getter(:white_light_brightness, :base, "whiteLightBrightness", &:to_i)
        add_setter(:white_light_brightness=, :base, "whiteLightBrightness", Integer)
        add_opt_range_getter(:white_light_brightness_opts, :capabilities, "SupplementLight/whiteLightBrightness")

        add_getter(:brightness_control, :base, "mixedLightBrightnessRegulatMode")
        add_setter(:brightness_control=, :base, "mixedLightBrightnessRegulatMode", String)
        add_opt_getter(:brightness_control_opts, :capabilities, "SupplementLight/mixedLightBrightnessRegulatMode")

        def url
          "#{@channel.url}/supplementLight"
        end

        private

        def load_capabilities(...)
          @channel.load_capabilities(...)
        end
      end
    end
  end
end
