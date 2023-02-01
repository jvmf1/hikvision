require 'hikvision'

cam = Hikvision::ISAPI.new('192.168.0.32', 'user', 'password')

channel = cam.streaming.channel(101)

puts channel.name
channel.name = 'NEW NAME'
channel.video_codec = 'H.264'
puts channel.edit
