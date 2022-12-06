module Hikvision
  class Streaming
    def initialize(isapi)
      @isapi = isapi
      @channels = {}
    end

    def channels
      @channels.values
    end

    def channel(id)
      @channels[id]
    end

    def load_channels(options = {})
      xml = @isapi.get_xml('/ISAPI/Streaming/channels', options)
      xml.StreamingChannelList.xpath('//StreamingChannel').each do |c|
        channel = Hikvision::StreamingChannel.new(@isapi, c)
        @channels[channel.id] = channel
      end
    end
  end
end
