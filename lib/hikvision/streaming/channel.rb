module Hikvision
  class Streaming
    class Channel < Hikvision::Base
      def initialize(isapi, xml)
        @isapi = isapi
        @base_xml = xml
      end

      add_xml(:base, -> { url })
      add_xml(:capabilities, -> { "#{url}/capabilities" })

      add_getter(:id, :base, '/StreamingChannel/id', &:to_i)

      add_getter(:name, :base, '/StreamingChannel/channelName')
      add_setter(:name=, :base, '/StreamingChannel/channelName', String)
      add_opt_range_getter(:name_length_opts, :capabilities, '/StreamingChannel/channelName')

      add_getter(:max_packet_size, :base, '/StreamingChannel/Transport/maxPacketSize', &:to_i)

      add_getter(:auth_type, :base, '/StreamingChannel/Transport/Security/certificateType')
      add_setter(:auth_type=, :base, '/StreamingChannel/Transport/Security/certificateType', String)
      add_opt_getter(:auth_type_opts, :capabilities, '/StreamingChannel/Transport/Security/certificateType', :to_s)

      add_getter(:video_framerate, :base, '/StreamingChannel/Video/maxFrameRate') { |v| v.to_f / 100 }
      add_setter(:video_framerate=, :base, '/StreamingChannel/Video/maxFrameRate', Numeric) { |v| (v * 100).to_i }
      add_opt_getter(:video_framerate_opts, :capabilities, '/StreamingChannel/Video/maxFrameRate', :to_f) { |v| v / 100 }

      add_getter(:video_width, :base, '/StreamingChannel/Video/videoResolutionWidth', &:to_i)
      add_setter(:video_width=, :base, '/StreamingChannel/Video/videoResolutionWidth', Integer)
      add_opt_getter(:video_width_opts, :capabilities, '/StreamingChannel/Video/videoResolutionWidth', :to_i)

      add_getter(:video_height, :base, '/StreamingChannel/Video/videoResolutionHeight', &:to_i)
      add_setter(:video_height=, :base, '/StreamingChannel/Video/videoResolutionHeight', Integer)
      add_opt_getter(:video_height_opts, :capabilities, '/StreamingChannel/Video/videoResolutionHeight', :to_i)

      add_getter(:video_cbitrate, :base, '/StreamingChannel/Video/constantBitRate', &:to_i)
      add_setter(:video_cbitrate=, :base, '/StreamingChannel/Video/constantBitRate', Integer)
      add_opt_range_getter(:video_cbitrate_opts, :capabilities, '/StreamingChannel/Video/constantBitRate')

      add_getter(:video_vbitrate_upper_cap, :base, '/StreamingChannel/Video/vbrUpperCap', &:to_i)
      add_setter(:video_vbitrate_upper_cap=, :base, '/StreamingChannel/Video/vbrUpperCap', Integer)
      add_opt_range_getter(:video_vbitrate_upper_cap_opts, :capabilities, '/StreamingChannel/Video/vbrUpperCap')

      add_getter(:video_keyframe_interval, :base, '/StreamingChannel/Video/keyFrameInterval') { |v| v.to_i / 1000 }
      add_setter(:video_keyframe_interval=, :base, '/StreamingChannel/Video/keyFrameInterval', Numeric) { |v| (v * 1000).to_i }
      add_opt_range_getter(:video_keyframe_interval_opts, :capabilities, '/StreamingChannel/Video/keyFrameInterval')

      add_getter(:video_codec, :base, '/StreamingChannel/Video/videoCodecType')
      add_setter(:video_codec=, :base, '/StreamingChannel/Video/videoCodecType', String)
      add_opt_getter(:video_codec_opts, :capabilities, '/StreamingChannel/Video/videoCodecType', :to_s)

      add_getter(:video_bitrate_type, :base, '/StreamingChannel/Video/videoQualityControlType')
      add_setter(:video_bitrate_type=, :base, '/StreamingChannel/Video/videoQualityControlType', String)
      add_opt_getter(:video_bitrate_type_opts, :capabilities, '/StreamingChannel/Video/videoQualityControlType', :to_s)

      add_getter(:video_scan_type, :base, '/StreamingChannel/Video/videoScanType')
      add_setter(:video_scan_type=, :base, '/StreamingChannel/Video/videoScanType', String)
      add_opt_getter(:video_scan_type_opts, :capabilities, '/StreamingChannel/Video/videoScanType', :to_s)

      add_getter(:snapshot_image_type, :base, '/StreamingChannel/Video/snapShotImageType')
      add_setter(:snapshot_image_type=, :base, '/StreamingChannel/Video/snapShotImageType', String)
      add_opt_getter(:snapshot_image_type_opts, :capabilities, '/StreamingChannel/Video/snapShotImageType', :to_s)

      add_getter(:audio_codec, :base, '/StreamingChannel/Audio/audioCompressionType')
      add_setter(:audio_codec=, :base, '/StreamingChannel/Audio/audioCompressionType', String)
      add_opt_getter(:audio_codec_opts, :capabilities, '/StreamingChannel/Audio/audioCompressionType', :to_s)

      add_getter(:video_smoothing, :base, '/StreamingChannel/Video/smoothing', &:to_i)
      add_opt_range_getter(:video_smoothing_opts, :capabilities, '/StreamingChannel/Video/smoothing')

      add_bool_getter(:audio_enabled?, :base, '/StreamingChannel/Audio/enabled')
      add_setter(:audio_enabled=, :base, '/StreamingChannel/Audio/enabled', TrueClass, FalseClass)

      add_bool_getter(:svc_enabled?, :base, '/StreamingChannel/Video/SVC/enabled')
      add_setter(:svc_enabled=, :base, '/StreamingChannel/Video/SVC/enabled', TrueClass, FalseClass)

      add_bool_getter(:enabled?, :base, '/StreamingChannel/enabled')
      add_bool_getter(:video_enabled?, :base, '/StreamingChannel/Video/enabled')
      add_bool_getter(:multicast_enabled?, :base, '/StreamingChannel/Transport/Multicast/enabled')
      add_bool_getter(:unicast_enabled?, :base, '/StreamingChannel/Transport/Unicast/enabled')
      add_bool_getter(:security_enabled?, :base, '/StreamingChannel/Transport/Security/enabled')

      def video_resolution
        [video_width, video_height]
      end

      def video_resolution=(value)
        video_width = value[0]
        video_height = value[1]
      end

      def video_resolution_opts
        video_width_opts.zip(video_height_opts)
      end

      def picture(options = { cache: false })
        @isapi.get("#{url}/picture", options).response.body
      end

      def update(options = {})
        options[:body] = @base_xml.to_s

        @isapi.cache.delete('/ISAPI/Streaming/channels')

        @isapi.put_xml(url, options)
      end

      def url
        "/ISAPI/Streaming/channels/#{id}"
      end
    end
  end
end
