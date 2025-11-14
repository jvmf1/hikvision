# frozen_string_literal: true

module Hikvision
  class System
    class VideoInput
      class Channel
        class Overlays < Hikvision::Base
          def initialize(isapi, channel)
            super()
            @isapi = isapi
            @channel = channel
          end

          add_xml(:base, -> { url })

          add_getter(:date_style, :base, "DateTimeOverlay/dateStyle")
          add_setter(:date_style=, :base, "DateTimeOverlay/dateStyle", String)
          add_opt_getter(:date_style_opts, :capabilities, "DateTimeOverlay/dateStyle")

          add_getter(:time_style, :base, "DateTimeOverlay/timeStyle")
          add_setter(:time_style=, :base, "DateTimeOverlay/timeStyle", String)
          add_opt_getter(:time_style_opts, :capabilities, "DateTimeOverlay/timeStyle")

          def url
            "#{@channel.url}/overlays"
          end

          private

          def load_capabilities(...)
            @channel.load_capabilities(...)
          end
        end
      end
    end
  end
end
