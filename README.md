# hikvision
Ruby Hikvision Interface

# example
```ruby
require 'hikvision'

cam = Hikvision::ISAPI.new('192.168.0.32', 'user', 'password')

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
$ hikvision -u user -p password -h 192.168.0.32 channel 101 --set-video-codec H.265

$ hikvision -u user -p password -h 192.168.0.32 channel 101 --video-codec
H.265
```

# install
```sh
git clone https://github.com/jvmf1/hikvision
cd hikvision
bundle install
gem build
gem install hikvision-*.gem --local
```
