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

def nets(face = nil)
  if face.nil?
    (nets('netctl-auto') + nets('netctl'))
      .uniq
      .map { |n|
        {
          name: n,
          iface: IO
            .read('/etc/netctl/' + n)
            .split("\n")
            .select { |l| l.split('=').first == 'Interface' }
            .first
            .split('=')
            .last,
          kind: {
            'w' => 'wireless',
            'e' => 'wired',
            'u' => 'tether'
          }[n[0]]
        }
      }
  else
    `#{face} list`
      .split("\n")
      .reject { |i| i[0] != '*' }
      .map { |i| i.split.last }
  end
end

rc = %w[lua config display]
  .map { |f| ERB.new(IO.read(f + '.erb')).result }
  .join "\n\n"

IO.write '/home/.conkyrc', rc
