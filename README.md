# hikvision
Ruby Hikvision Interface

# example
```ruby
require 'hikvision'

cam = Hikvision::ISAPI.new('192.168.0.32', 'user', 'password')
cam.streaming.load_channels

channel = cam.streaming.channel(101)

puts channel.name
channel.name = 'NEW NAME'
channel.video_codec = 'H.264'
channel.edit
```

# hikvision cli example
```sh
$ hikvision -u user -p password -h 192.168.0.32 channel 101 --video-codec --video-framerate
H.264
30.0
```

# install
```sh
bundle install
gem build
gem install hikviion-*.gem
```
