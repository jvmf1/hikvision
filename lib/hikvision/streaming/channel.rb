module Hikvision
  class StreamingChannel
    attr_reader :xml, :cxml

    def initialize(isapi, xml)
      @isapi = isapi
      @xml = xml
    end

    # basic getters
    [
      ['id', 'id', 'to_i'],
      ['name', 'channelName', 'to_s'],
      ['video_framerate', 'Video/maxFrameRate', 'to_i'],
      ['video_cbitrate', 'Video/constantBitRate', 'to_i'],
      ['video_keyframe_interval', 'Video/keyFrameInterval', 'to_i'],
      ['video_codec', 'Video/videoCodecType', 'to_s'],
      ['video_bitrate_type', 'Video/videoQualityControlType', 'to_s'],
      ['video_scan_type', 'Video/videoScanType', 'to_s'],
      ['snapshot_image_type', 'Video/snapShotImageType', 'to_s'],
      ['video_smoothing', 'Video/smoothing', 'to_i']
    ].each do |method, path, transform|
      define_method method do
        @xml.at_xpath(path).inner_html.send(transform)
      end
    end

    # basic setters
    [
      ['video_framerate=', 'Video/maxFrameRate'],
      ['video_keyframe_interval=', 'Video/keyFrameInterval'],
      ['video_codec=', 'Video/videoCodecType'],
      ['video_cbitrate=', 'Video/constantBitRate'],
      ['video_bitrate_type=', 'Video/videoQualityControlType'],
      ['video_scan_type=', 'Video/videoScanType'],
      ['snapshot_image_type=', 'Video/snapShotImageType'],
      ['name=', 'channelName']
    ].each do |method, path|
      define_method method do |value|
        @xml.at_xpath(path).inner_html = value.to_s
      end
    end

    # basic capabilities getters
    [
      ['video_codec_capabilities', 'Video/videoCodecType', 'to_s'],
      ['video_bitrate_type_capabilities', 'Video/videoQualityControlType', 'to_s'],
      ['video_scan_type_capabilities', 'Video/videoScanType', 'to_s'],
      ['snapshot_image_type_capabilities', 'Video/snapShotImageType', 'to_s'],
      ['video_framerate_capabilities', 'Video/maxFrameRate', 'to_i']
    ].each do |method, path, transform|
      define_method method do
        require_cxml
        @cxml.at_xpath(path)[:opt].split(',').map { |v| v.send(transform) }
      end
    end

    # basic range capabilities getters
    [
      ['video_smoothing_capabilities', 'Video/smoothing'],
      ['name_length_capabilities', 'channelName'],
      ['video_cbitrate_capabilities', 'Video/constantBitRate'],
      ['video_keyframe_interval_capabilities', 'Video/keyFrameInterval']
    ].each do |method, path|
      define_method method do
        require_cxml
        @cxml.at_xpath(path)[:min].to_i..@cxml.at_xpath(path)[:max].to_i
      end
    end

    def video_resolution
      [@xml.at_xpath('Video/videoResolutionWidth').inner_html.to_i,
       @xml.at_xpath('Video/videoResolutionHeight').inner_html.to_i]
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

    def video_enabled?
      @xml.at_xpath('Video/enabled').inner_html == 'true'
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
