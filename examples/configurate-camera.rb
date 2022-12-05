require 'hikvision'

cam = Hikvision::ISAPI.new('192.168.0.32', 'user', 'password')
cam.streaming.load_channels

channel = cam.streaming.channel(101)

puts channel.name
channel.name = "NEW NAME"
channel.edit
