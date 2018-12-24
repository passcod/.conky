#!/usr/bin/env ruby

require 'erb'

def tz
  `ls -l /etc/localtime`
    .split
    .last
    .split('/')
    .last(2)
    .join('/')
end

def times
  [tz]
end

def nets
  list = `nmcli dev`.split("\n")
  list.shift
  list.map { |conn|
    conn = conn.split
    {iface: conn[0], kind: conn[1]}
  }.reject { |conn|
    conn[:kind] =~ /(bridge|tun)/ || conn[:iface] =~ /(veth|^lo$)/
  }
end

def disks
  {
    efi:    '/boot/efi',
    root:   '/',
    home:   '/home',
  }
end

rc = %w[lua config display]
  .map { |f| ERB.new(IO.read(f + '.erb')).result }
  .join "\n\n"

IO.write '/home/.conkyrc', rc
