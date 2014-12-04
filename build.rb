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
  if tz == 'Pacific/Auckland'
    [tz, 'Europe/Paris']
  else
    [tz, 'Pacific/Auckland']
  end
end

def nets
  `nmcli dev`.split("\n").grep(/\sconnect/).map { |conn|
    conn = conn.split
    {iface: conn[0], kind: conn[1]}
  }
end

def disks
  {
    efi:    '/boot/efi',
    root:   '/',
    home:   '/home',
    docker: '/var/lib/docker'
  }
end

rc = %w[lua config display]
  .map { |f| ERB.new(IO.read(f + '.erb')).result }
  .join "\n\n"

IO.write '/home/.conkyrc', rc
