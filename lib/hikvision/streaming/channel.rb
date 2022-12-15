module Hikvision
  class StreamingChannel < Hikvision::Base
    attr_reader :xml, :cxml

    def initialize(isapi, xml)
      @isapi = isapi
      @xml = xml
    end

    add_getter(:id, :@xml, 'id', :to_i)
    add_getter(:name, :@xml, 'channelName', :to_s)
    add_getter(:max_packet_size, :@xml, 'Transport/maxPacketSize', :to_i)
    add_getter(:auth_type, :@xml, 'Transport/Security/certificateType', :to_s)
    add_getter(:video_framerate, :@xml, 'Video/maxFrameRate', :to_i)
    add_getter(:video_resolution_width, :@xml, 'Video/videoResolutionWidth', :to_i)
    add_getter(:video_resolution_height, :@xml, 'Video/videoResolutionHeight', :to_i)
    add_getter(:video_cbitrate, :@xml, 'Video/constantBitRate', :to_i)
    add_getter(:video_keyframe_interval, :@xml, 'Video/keyFrameInterval', :to_i)
    add_getter(:video_codec, :@xml, 'Video/videoCodecType', :to_s)
    add_getter(:video_bitrate_type, :@xml, 'Video/videoQualityControlType', :to_s)
    add_getter(:video_scan_type, :@xml, 'Video/videoScanType', :to_s)
    add_getter(:snapshot_image_type, :@xml, 'Video/snapShotImageType', :to_s)
    add_getter(:audio_codec, :@xml, 'Audio/audioCompressionType', :to_s)
    add_getter(:video_smoothing, :@xml, 'Video/smoothing', :to_i)

    add_bool_getter(:enabled?, :@xml, 'enabled')
    add_bool_getter(:video_enabled?, :@xml, 'Video/enabled')
    add_bool_getter(:audio_enabled?, :@xml, 'Audio/enabled')
    add_bool_getter(:multicast_enabled?, :@xml, 'Transport/Multicast/enabled')
    add_bool_getter(:unicast_enabled?, :@xml, 'Transport/Unicast/enabled')
    add_bool_getter(:security_enabled?, :@xml, 'Transport/Security/enabled')

    add_setter(:name=, :@xml, 'channelName')
    add_setter(:video_framerate=, :@xml, 'Video/maxFrameRate')
    add_setter(:video_codec=, :@xml, 'Video/videoCodecType')
    add_setter(:video_keyframe_interval=, :@xml, 'Video/keyFrameInterval')
    add_setter(:video_cbitrate=, :@xml, 'Video/constantBitRate')
    add_setter(:video_resolution_width=, :@xml, 'Video/videoResolutionWidth')
    add_setter(:video_resolution_height=, :@xml, 'Video/videoResolutionHeight')
    add_setter(:video_bitrate_type=, :@xml, 'Video/videoQualityControlType')
    add_setter(:video_scan_type=, :@xml, 'Video/videoScanType')
    add_setter(:snapshot_image_type=, :@xml, 'Video/snapShotImageType')
    add_setter(:auth_type=, :@xml, 'Transport/Security/certificateType')

    add_opt_getter(:video_codec_opts, :@cxml, 'Video/videoCodecType', :to_s)
    add_opt_getter(:audio_codec_opts, :@cxml, 'Audio/audioCompressionType', :to_s)
    add_opt_getter(:video_bitrate_type_opts, :@cxml, 'Video/videoQualityControlType', :to_s)
    add_opt_getter(:video_scan_type_opts, :@cxml, 'Video/videoScanType', :to_s)
    add_opt_getter(:video_resolution_width_opts, :@cxml, 'Video/videoResolutionWidth', :to_s)
    add_opt_getter(:video_resolution_height_opts, :@cxml, 'Video/videoResolutionHeight', :to_s)
    add_opt_getter(:snapshot_image_type_opts, :@cxml, 'Video/snapShotImageType', :to_s)
    add_opt_getter(:video_framerate_opts, :@cxml, 'Video/maxFrameRate', :to_s)
    add_opt_getter(:auth_type_opts, :@cxml, 'Transport/Security/certificateType', :to_s)

    add_opt_range_getter(:video_smoothing_opts, :@cxml, 'Video/smoothing')
    add_opt_range_getter(:video_cbitrate_opts, :@cxml, 'Video/constantBitRate')
    add_opt_range_getter(:video_keyframe_interval_opts, :@cxml, 'Video/keyFrameInterval')
    add_opt_range_getter(:name_length_opts, :@cxml, 'channelName')

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

    def reload(options = {})
      @xml = @isapi.get_xml(url, options).at_xpath('StreamingChannel')
    end

    def edit(options = {})
      options[:body] = @xml.xpath('/').to_s

      @isapi.cache.delete('/ISAPI/Streaming/channels')

      @isapi.put(url, options)
    end

    def load_opts(options = {})
      @cxml = @isapi.get_xml("#{url}/capabilities", options).at_xpath('StreamingChannel')
    end

    def url
      "/ISAPI/Streaming/channels/#{id}"
    end
  end
end
