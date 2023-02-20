module Hikvision
  class Streaming
    class Channel < Hikvision::Base
      def initialize(isapi, xml)
        @isapi = isapi
        @base_xml = xml
      end

      add_xml(:base, -> { url }, 'StreamingChannel')

      add_getter(:id, :base, 'id') { |v| v.to_i }
      add_getter(:name, :base, 'channelName')
      add_getter(:max_packet_size, :base, 'Transport/maxPacketSize') { |v| v.to_i }
      add_getter(:auth_type, :base, 'Transport/Security/certificateType')
      add_getter(:video_framerate, :base, 'Video/maxFrameRate') { |v| v.to_f / 100 }
      add_getter(:video_width, :base, 'Video/videoResolutionWidth') { |v| v.to_i }
      add_getter(:video_height, :base, 'Video/videoResolutionHeight') { |v| v.to_i }
      add_getter(:video_cbitrate, :base, 'Video/constantBitRate') { |v| v.to_i }
      add_getter(:video_vbitrate_upper_cap, :base, 'Video/vbrUpperCap') { |v| v.to_i }
      add_getter(:video_keyframe_interval, :base, 'Video/keyFrameInterval') { |v| v.to_i / 1000 }
      add_getter(:video_codec, :base, 'Video/videoCodecType')
      add_getter(:video_bitrate_type, :base, 'Video/videoQualityControlType')
      add_getter(:video_scan_type, :base, 'Video/videoScanType')
      add_getter(:snapshot_image_type, :base, 'Video/snapShotImageType')
      add_getter(:audio_codec, :base, 'Audio/audioCompressionType')
      add_getter(:video_smoothing, :base, 'Video/smoothing') { |v| v.to_i }

      add_bool_getter(:enabled?, :base, 'enabled')
      add_bool_getter(:svc_enabled?, :base, 'Video/SVC/enabled')
      add_bool_getter(:video_enabled?, :base, 'Video/enabled')
      add_bool_getter(:audio_enabled?, :base, 'Audio/enabled')
      add_bool_getter(:multicast_enabled?, :base, 'Transport/Multicast/enabled')
      add_bool_getter(:unicast_enabled?, :base, 'Transport/Unicast/enabled')
      add_bool_getter(:security_enabled?, :base, 'Transport/Security/enabled')

      add_setter(:name=, :base, 'channelName', String)
      add_setter(:video_framerate=, :base, 'Video/maxFrameRate', Numeric) { |v| (v * 100).to_i }
      add_setter(:video_codec=, :base, 'Video/videoCodecType', String)
      add_setter(:audio_codec=, :base, 'Audio/audioCompressionType', String)
      add_setter(:video_keyframe_interval=, :base, 'Video/keyFrameInterval', Numeric) { |v| (v * 1000).to_i }
      add_setter(:video_cbitrate=, :base, 'Video/constantBitRate', Integer)
      add_setter(:video_vbitrate_upper_cap=, :base, 'Video/vbrUpperCap', Integer)
      add_setter(:video_width=, :base, 'Video/videoResolutionWidth', Integer)
      add_setter(:video_height=, :base, 'Video/videoResolutionHeight', Integer)
      add_setter(:video_bitrate_type=, :base, 'Video/videoQualityControlType', String)
      add_setter(:video_scan_type=, :base, 'Video/videoScanType', String)
      add_setter(:snapshot_image_type=, :base, 'Video/snapShotImageType', String)
      add_setter(:auth_type=, :base, 'Transport/Security/certificateType', String)
      add_setter(:audio_enabled=, :base, 'Audio/enabled', TrueClass, FalseClass)
      add_setter(:svc_enabled=, :base, 'Video/SVC/enabled', TrueClass, FalseClass)

      add_xml(:capabilities, -> { "#{url}/capabilities" }, "StreamingChannel" )

      add_opt_getter(:video_codec_opts, :capabilities, 'Video/videoCodecType', :to_s)
      add_opt_getter(:audio_codec_opts, :capabilities, 'Audio/audioCompressionType', :to_s)
      add_opt_getter(:video_bitrate_type_opts, :capabilities, 'Video/videoQualityControlType', :to_s)
      add_opt_getter(:video_scan_type_opts, :capabilities, 'Video/videoScanType', :to_s)
      add_opt_getter(:video_width_opts, :capabilities, 'Video/videoResolutionWidth', :to_i)
      add_opt_getter(:video_height_opts, :capabilities, 'Video/videoResolutionHeight', :to_i)
      add_opt_getter(:snapshot_image_type_opts, :capabilities, 'Video/snapShotImageType', :to_s)
      add_opt_getter(:video_framerate_opts, :capabilities, 'Video/maxFrameRate', :to_f) { |v| v / 100 }
      add_opt_getter(:auth_type_opts, :capabilities, 'Transport/Security/certificateType', :to_s)

      add_opt_range_getter(:video_smoothing_opts, :capabilities, 'Video/smoothing')
      add_opt_range_getter(:video_cbitrate_opts, :capabilities, 'Video/constantBitRate')
      add_opt_range_getter(:video_vbitrate_upper_cap_opts, :capabilities, 'Video/vbrUpperCap')
      add_opt_range_getter(:video_keyframe_interval_opts, :capabilities, 'Video/keyFrameInterval')
      add_opt_range_getter(:name_length_opts, :capabilities, 'channelName')

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
        options[:body] = @base_xml.xpath('/').to_s

        @isapi.cache.delete('/ISAPI/Streaming/channels')

        @isapi.put(url, options)
      end

      def url
        "/ISAPI/Streaming/channels/#{id}"
      end
    end
  end
end
