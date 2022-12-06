module Hikvision
  class StreamingChannel
    attr_reader :xml, :cxml

    def initialize(isapi, xml)
      @isapi = isapi
      @xml = xml
    end

    def id
      @xml.xpath('id').inner_html.to_i
    end

    def video_fps
      @xml.Video.maxFrameRate.inner_html.to_i
    end

    def video_fps=(value)
      @xml.Video.maxFrameRate.inner_html = value.to_s
    end

    def video_fps_capabilities
      @cxml.Video.maxFrameRate[:opt].split(',').map { |f| f.to_i }
    end

    def video_resolution
      [@xml.Video.videoResolutionWidth.inner_html.to_i, @xml.Video.videoResolutionHeight.inner_html.to_i]
    end

    def video_resolution=(value)
      @xml.Video.videoResolutionWidth.inner_html = value[0].to_s
      @xml.Video.videoResolutionHeight.inner_html = value[1].to_s
    end

    def video_resolution_capabilities
      ws = @cxml.Video.videoResolutionWidth[:opt].split(',').map {|w| w.to_i}
      hs = @cxml.Video.videoResolutionHeight[:opt].split(',').map {|h| h.to_i}
      ws.zip(hs)
    end

    def video_codec
      @xml.Video.videoCodecType.inner_html
    end

    def video_codec=(value)
      @xml.Video.videoCodecType.inner_html = value
    end

    def video_codec_capabilities
      @cxml.Video.videoCodecType[:opt].split(',') if @cxml
    end

    def video_bitrate_type
      @xml.Video.videoQualityControlType.inner_html
    end

    def video_bitrate_type=(value)
      @xml.Video.videoQualityControlType.inner_html = value
    end

    def video_bitrate_type_capabilities
      @cxml.Video.videoQualityControlType[:opt].split(',') if @cxml
    end

    def video_smoothing
      @xml.Video.smoothing.inner_html.to_i
    end

    def video_smoothing=(value)
      @xml.Video.smoothing.inner_html = value.to_s
    end

    def video_smoothing_capabilities
      @cxml.Video.smoothing[:min].to_i..@cxml.Video.smoothing[:max].to_i if @cxml
    end

    def video_cbitrate
      @xml.Video.constantBitRate.inner_html.to_i
    end

    def video_cbitrate=(value)
      @xml.Video.constantBitRate.inner_html = value.to_s
    end

    def video_cbitrate_capabilities
      @cxml.Video.constantBitRate[:min].to_i..@cxml.Video.constantBitRate[:max].to_i if @cxml
    end

    def video_enabled?
      @xml.Video.enabled.inner_html == 'true'
    end

    def video_scan_type
      @xml.Video.videoScanType.inner_html
    end

    def video_scan_type=(value)
      @xml.Video.videoScanType.inner_html = value
    end

    def video_scan_type_capabilities
      @cxml.Video.videoScanType[:opt].split(',')
    end

    def snapshot_image_type
      @xml.Video.snapShotImageType.inner_html
    end

    def snapshot_image_type=(value)
      @xml.Video.snapShotImageType.inner_html = value
    end

    def snapshot_image_type_capabilities
      @cxml.Video.snapShotImageType[:opt].split(',')
    end

    def name
      @xml.channelName.inner_html
    end

    def name=(value)
      @xml.channelName.inner_html = value
    end

    def name_capabilities
      @cxml.channelName[:min].to_i..@cxml.channelName[:max].to_i if @cxml
    end

    def enabled?
      @xml.enabled.inner_html == 'true'
    end

    def picture(options = { cache: false })
      @isapi.get("#{url}/picture", options).response.body
    end

    def reload(options = {})
      @xml = @isapi.get_xml(url, options).StreamingChannel
    end

    def edit(options = {})
      options[:body] = @xml.xpath('/').to_s

      @isapi.cache.delete('/ISAPI/Streaming/channels')

      @isapi.put(url, options)
    end

    def load_capabilities(options = {})
      @cxml = @isapi.get_xml("#{url}/capabilities", options).StreamingChannel
    end

    def url
      "/ISAPI/Streaming/channels/#{id}"
    end
  end
end
