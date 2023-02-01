require 'hikvision'

f = File.open('img.jpeg', 'w+b')

cam = Hikvision::ISAPI.new('192.168.0.32', 'user', 'password')

channel = cam.streaming.channel(101)

f.write(channel.picture)
f.close
