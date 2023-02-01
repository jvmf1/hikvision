module Hikvision
  class StreamingChannel < Hikvision::Base
    def initialize(isapi, xml)
      @isapi = isapi
      @base_xml = xml
    end

    add_xml(:base, -> { url }, 'StreamingChannel')

    def reload(options = {})
      load_base(options.merge(cache: false))
    end

    add_getter(:id, :base, 'id', :to_i)
    add_getter(:name, :base, 'channelName', :to_s)
    add_getter(:max_packet_size, :base, 'Transport/maxPacketSize', :to_i)
    add_getter(:auth_type, :base, 'Transport/Security/certificateType', :to_s)
    add_getter(:video_framerate, :base, 'Video/maxFrameRate', :to_i)
    add_getter(:video_resolution_width, :base, 'Video/videoResolutionWidth', :to_i)
    add_getter(:video_resolution_height, :base, 'Video/videoResolutionHeight', :to_i)
    add_getter(:video_cbitrate, :base, 'Video/constantBitRate', :to_i)
    add_getter(:video_keyframe_interval, :base, 'Video/keyFrameInterval', :to_i)
    add_getter(:video_codec, :base, 'Video/videoCodecType', :to_s)
    add_getter(:video_bitrate_type, :base, 'Video/videoQualityControlType', :to_s)
    add_getter(:video_scan_type, :base, 'Video/videoScanType', :to_s)
    add_getter(:snapshot_image_type, :base, 'Video/snapShotImageType', :to_s)
    add_getter(:audio_codec, :base, 'Audio/audioCompressionType', :to_s)
    add_getter(:video_smoothing, :base, 'Video/smoothing', :to_i)

    add_bool_getter(:enabled?, :base, 'enabled')
    add_bool_getter(:svc_enabled?, :base, 'Video/SVC/enabled')
    add_bool_getter(:video_enabled?, :base, 'Video/enabled')
    add_bool_getter(:audio_enabled?, :base, 'Audio/enabled')
    add_bool_getter(:multicast_enabled?, :base, 'Transport/Multicast/enabled')
    add_bool_getter(:unicast_enabled?, :base, 'Transport/Unicast/enabled')
    add_bool_getter(:security_enabled?, :base, 'Transport/Security/enabled')

    add_setter(:name=, :base, 'channelName', [String])
    add_setter(:video_framerate=, :base, 'Video/maxFrameRate', [Integer])
    add_setter(:video_codec=, :base, 'Video/videoCodecType', [String])
    add_setter(:audio_codec=, :base, 'Audio/audioCompressionType', [String])
    add_setter(:video_keyframe_interval=, :base, 'Video/keyFrameInterval', [Integer])
    add_setter(:video_cbitrate=, :base, 'Video/constantBitRate', [Integer])
    add_setter(:video_resolution_width=, :base, 'Video/videoResolutionWidth', [Integer])
    add_setter(:video_resolution_height=, :base, 'Video/videoResolutionHeight', [Integer])
    add_setter(:video_bitrate_type=, :base, 'Video/videoQualityControlType', [String])
    add_setter(:video_scan_type=, :base, 'Video/videoScanType', [String])
    add_setter(:snapshot_image_type=, :base, 'Video/snapShotImageType', [String])
    add_setter(:auth_type=, :base, 'Transport/Security/certificateType', [String])
    add_setter(:audio_enabled=, :base, 'Audio/enabled', [TrueClass, FalseClass])
    add_setter(:svc_enabled=, :base, 'Video/SVC/enabled', [TrueClass, FalseClass])

    add_xml(:capabilities, -> { "#{url}/capabilities" }, "StreamingChannel" )

    add_opt_getter(:video_codec_opts, :capabilities, 'Video/videoCodecType', :to_s)
    add_opt_getter(:audio_codec_opts, :capabilities, 'Audio/audioCompressionType', :to_s)
    add_opt_getter(:video_bitrate_type_opts, :capabilities, 'Video/videoQualityControlType', :to_s)
    add_opt_getter(:video_scan_type_opts, :capabilities, 'Video/videoScanType', :to_s)
    add_opt_getter(:video_resolution_width_opts, :capabilities, 'Video/videoResolutionWidth', :to_i)
    add_opt_getter(:video_resolution_height_opts, :capabilities, 'Video/videoResolutionHeight', :to_i)
    add_opt_getter(:snapshot_image_type_opts, :capabilities, 'Video/snapShotImageType', :to_s)
    add_opt_getter(:video_framerate_opts, :capabilities, 'Video/maxFrameRate', :to_i)
    add_opt_getter(:auth_type_opts, :capabilities, 'Transport/Security/certificateType', :to_s)

    add_opt_range_getter(:video_smoothing_opts, :capabilities, 'Video/smoothing')
    add_opt_range_getter(:video_cbitrate_opts, :capabilities, 'Video/constantBitRate')
    add_opt_range_getter(:video_keyframe_interval_opts, :capabilities, 'Video/keyFrameInterval')
    add_opt_range_getter(:name_length_opts, :capabilities, 'channelName')

    def video_resolution
      [video_resolution_width, video_resolution_height]
    end

    def video_resolution=(value)
      video_resolution_width = value[0]
      video_resolution_height = value[1]
    end

    def video_resolution_opts
      video_resolution_width_opts.zip(video_resolution_height_opts)
    end

    def picture(options = { cache: false })
      @isapi.get("#{url}/picture", options).response.body
    end

    def edit(options = {})
      options[:body] = @base_xml.xpath('/').to_s

      @isapi.cache.delete('/ISAPI/Streaming/channels')

      @isapi.put(url, options)
    end

    def url
      "/ISAPI/Streaming/channels/#{id}"
    end
  end
end
