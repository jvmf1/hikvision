module Hikvision
  class Streaming
    class Channel < Hikvision::Base
      def initialize(isapi, xml)
        @isapi = isapi
        @base_xml = xml
      end

      add_xml(:base, -> { url })
      add_xml(:capabilities, -> { "#{url}/capabilities" })

      add_getter(:id, :base, '//id', &:to_i)

      add_getter(:name, :base, '//channelName')
      add_setter(:name=, :base, '//channelName', String)
      add_opt_range_getter(:name_length_opts, :capabilities, '//channelName')

      add_getter(:max_packet_size, :base, '//Transport/maxPacketSize', &:to_i)

      add_getter(:auth_type, :base, '//Transport/Security/certificateType')
      add_setter(:auth_type=, :base, '//Transport/Security/certificateType', String)
      add_opt_getter(:auth_type_opts, :capabilities, '//Transport/Security/certificateType', :to_s)

      add_getter(:video_framerate, :base, '//Video/maxFrameRate') { |v| v.to_f / 100 }
      add_setter(:video_framerate=, :base, '//Video/maxFrameRate', Numeric) { |v| (v * 100).to_i }
      add_opt_getter(:video_framerate_opts, :capabilities, '//Video/maxFrameRate', :to_f) { |v| v / 100 }

      add_getter(:video_width, :base, '//videoResolutionWidth', &:to_i)
      add_setter(:video_width=, :base, '//videoResolutionWidth', Integer)
      add_opt_getter(:video_width_opts, :capabilities, '//videoResolutionWidth', :to_i)

      add_getter(:video_height, :base, '//videoResolutionHeight', &:to_i)
      add_setter(:video_height=, :base, '//videoResolutionHeight', Integer)
      add_opt_getter(:video_height_opts, :capabilities, '//videoResolutionHeight', :to_i)

      add_getter(:video_cbitrate, :base, '//Video/constantBitRate', &:to_i)
      add_setter(:video_cbitrate=, :base, '//Video/constantBitRate', Integer)
      add_opt_range_getter(:video_cbitrate_opts, :capabilities, '//Video/constantBitRate')

      add_getter(:video_vbitrate_upper_cap, :base, '//Video/vbrUpperCap', &:to_i)
      add_setter(:video_vbitrate_upper_cap=, :base, '//Video/vbrUpperCap', Integer)
      add_opt_range_getter(:video_vbitrate_upper_cap_opts, :capabilities, '//Video/vbrUpperCap')

      add_getter(:video_keyframe_interval, :base, '//Video/keyFrameInterval') { |v| v.to_i / 1000 }
      add_setter(:video_keyframe_interval=, :base, '//Video/keyFrameInterval', Numeric) { |v| (v * 1000).to_i }
      add_opt_range_getter(:video_keyframe_interval_opts, :capabilities, '//Video/keyFrameInterval')

      add_getter(:video_codec, :base, '//videoCodecType')
      add_setter(:video_codec=, :base, '//videoCodecType', String)
      add_opt_getter(:video_codec_opts, :capabilities, '//videoCodecType', :to_s)

      add_getter(:video_bitrate_type, :base, '//videoQualityControlType')
      add_setter(:video_bitrate_type=, :base, '//videoQualityControlType', String)
      add_opt_getter(:video_bitrate_type_opts, :capabilities, '//videoQualityControlType', :to_s)

      add_getter(:video_scan_type, :base, '//videoScanType')
      add_setter(:video_scan_type=, :base, '//videoScanType', String)
      add_opt_getter(:video_scan_type_opts, :capabilities, '//videoScanType', :to_s)

      add_getter(:snapshot_image_type, :base, '//snapShotImageType')
      add_setter(:snapshot_image_type=, :base, '//snapShotImageType', String)
      add_opt_getter(:snapshot_image_type_opts, :capabilities, '//snapShotImageType', :to_s)

      add_getter(:audio_codec, :base, '//audioCompressionType')
      add_setter(:audio_codec=, :base, '//audioCompressionType', String)
      add_opt_getter(:audio_codec_opts, :capabilities, '//audioCompressionType', :to_s)

      add_getter(:video_smoothing, :base, '//Video/smoothing', &:to_i)
      add_opt_range_getter(:video_smoothing_opts, :capabilities, '//Video/smoothing')

      add_bool_getter(:audio_enabled?, :base, '//Audio/enabled')
      add_setter(:audio_enabled=, :base, '//Audio/enabled', TrueClass, FalseClass)

      add_bool_getter(:svc_enabled?, :base, '//Video/SVC/enabled')
      add_setter(:svc_enabled=, :base, '//Video/SVC/enabled', TrueClass, FalseClass)

      add_bool_getter(:enabled?, :base, '/StreamingChannel/enabled')
      add_bool_getter(:video_enabled?, :base, '//Video/enabled')
      add_bool_getter(:multicast_enabled?, :base, '//Transport/Multicast/enabled')
      add_bool_getter(:unicast_enabled?, :base, '//Transport/Unicast/enabled')
      add_bool_getter(:security_enabled?, :base, '//Transport/Security/enabled')

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

      def url
        "/ISAPI/Streaming/channels/#{id}"
      end

      private

      def before_update
        @isapi.cache.delete('/ISAPI/Streaming/channels')
      end
    end
  end
end
