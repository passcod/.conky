#!/bin/zsh

#SENSOR="Core 0"
SENSOR=TCXC

if [ -z "$1" ]; then
  echo -n "∆ "
fi
sensors | grep "$SENSOR" | grep -Po "\+[\d.]+°C" | head -n1 | sed 's/[\+C]//g'
