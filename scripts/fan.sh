#!/bin/zsh

speed=$(sensors | grep Exhaust | grep -Po "\d+" | head -n1)

if echo $1 | grep -q conky; then
  let speed-=1900
  let speed/=43
  echo $speed
else
  echo $speed RPM
fi
