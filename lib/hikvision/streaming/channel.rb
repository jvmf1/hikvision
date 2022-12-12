module Hikvision
  class StreamingChannel
    attr_reader :xml, :cxml

    def initialize(isapi, xml)
      @isapi = isapi
      @xml = xml
    end

    def id
      @xml.at_xpath('id').inner_html.to_i
    end

    def video_framerate
      @xml.at_xpath('Video/maxFrameRate').inner_html.to_i
    end

    def video_framerate=(value)
      @xml.at_xpath('Video/maxFrameRate').inner_html = value.to_s
    end

    def video_framerate_capabilities
      require_cxml
      @cxml.at_xpath('Video/maxFrameRate')[:opt].split(',').map { |f| f.to_i }
    end

    def video_resolution
      [@xml.at_xpath('Video/videoResolutionWidth').inner_html.to_i, @xml.at_xpath('Video/videoResolutionHeight').inner_html.to_i]
    end

    def video_resolution=(value)
      @xml.at_xpath('Video/videoResolutionWidth').inner_html = value[0].to_s
      @xml.at_xpath('Video/videoResolutionHeight').inner_html = value[1].to_s
    end

    def video_resolution_capabilities
      require_cxml
      ws = @cxml.at_xpath('Video/videoResolutionWidth')[:opt].split(',').map { |w| w.to_i }
      hs = @cxml.at_xpath('Video/videoResolutionHeight')[:opt].split(',').map { |h| h.to_i }
      ws.zip(hs)
    end

    def video_keyframe_interval
      @xml.at_xpath('Video/keyFrameInterval').inner_html.to_i
    end

    def video_keyframe_interval=(value)
      @xml.at_xpath('Video/keyFrameInterval').inner_html = value.to_s
    end

    def video_keyframe_interval_capabilities
      require_cxml
      @cxml.at_xpath('Video/keyFrameInterval')[:min].to_i..@cxml.at_xpath('Video/keyFrameInterval')[:max].to_i
    end

    def video_codec
      @xml.at_xpath('Video/videoCodecType').inner_html
    end

    def video_codec=(value)
      @xml.at_xpath('Video/videoCodecType').inner_html = value
    end

    def video_codec_capabilities
      require_cxml
      @cxml.at_xpath('Video/videoCodecType')[:opt].split(',')
    end

    def video_bitrate_type
      @xml.at_xpath('Video/videoQualityControlType').inner_html
    end

    def video_bitrate_type=(value)
      @xml.at_xpath('Video/videoQualityControlType').inner_html = value
    end

    def video_bitrate_type_capabilities
      require_cxml
      @cxml.at_xpath('Video/videoQualityControlType')[:opt].split(',')
    end

    def video_smoothing
      @xml.at_xpath('Video/smoothing').inner_html.to_i
    end

    def video_smoothing=(value)
      @xml.at_xpath('Video/smoothing').inner_html = value.to_s
    end

    def video_smoothing_capabilities
      require_cxml
      @cxml.at_xpath('Video/smoothing')[:min].to_i..@cxml.at_xpath('Video/smoothing')[:max].to_i
    end

    def video_cbitrate
      @xml.at_xpath('Video/constantBitRate').inner_html.to_i
    end

    def video_cbitrate=(value)
      @xml.at_xpath('Video/constantBitRate').inner_html = value.to_s
    end

    def video_cbitrate_capabilities
      require_cxml
      @cxml.at_xpath('Video/constantBitRate')[:min].to_i..@cxml.at_xpath('Video/constantBitRate')[:max].to_i
    end

    def video_enabled?
      @xml.at_xpath('Video/enabled').inner_html == 'true'
    end

    def video_scan_type
      @xml.at_xpath('Video/videoScanType').inner_html
    end

    def video_scan_type=(value)
      @xml.at_xpath('Video/videoScanType').inner_html = value
    end

    def video_scan_type_capabilities
      require_cxml
      @cxml.at_xpath('Video/videoScanType')[:opt].split(',')
    end

    def snapshot_image_type
      @xml.at_xpath('Video/snapShotImageType').inner_html
    end

    def snapshot_image_type=(value)
      @xml.at_xpath('Video/snapShotImageType').inner_html = value
    end

    def snapshot_image_type_capabilities
      require_cxml
      @cxml.at_xpath('Video/snapShotImageType')[:opt].split(',')
    end

    def name
      @xml.at_xpath('channelName').inner_html
    end

    def name=(value)
      @xml.at_xpath('channelName').inner_html = value
    end

    def name_capabilities
      require_cxml
      @cxml.at_xpath('channelName')[:min].to_i..@cxml.at_xpath('channelName')[:max].to_i
    end

    def enabled?
      @xml.at_xpath('enabled').inner_html == 'true'
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

    def load_capabilities(options = {})
      @cxml = @isapi.get_xml("#{url}/capabilities", options).at_xpath('StreamingChannel')
    end

    def url
      "/ISAPI/Streaming/channels/#{id}"
    end

    private

    def require_cxml
      raise 'load_capabilities is required' unless @cxml
    end
  end
end
