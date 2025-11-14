# frozen_string_literal: true

module Hikvision
  class System
    class VideoInput
      class Channel < Hikvision::Base
        attr_reader :overlays

        def initialize(isapi, xml)
          super()
          @isapi = isapi
          @base_xml = xml
          @overlays = Overlays.new(isapi, self)
        end

        add_xml(:base, -> { url })
        add_xml(:capabilities, -> { "#{url}/capabilities" })

        add_getter(:id, :base, "id", &:to_i)

        add_getter(:video_format, :base, "videoFormat")
        add_setter(:video_format=, :base, "videoFormat", String)
        add_opt_getter(:video_format_opts, :capabilities, "videoFormat")

        def url
          "/ISAPI/System/Video/inputs/channels/#{id}"
        end

        private

        def before_update
          @isapi.cache.delete("/ISAPI/System/Video/inputs/channels")
        end
      end
    end
  end
end
