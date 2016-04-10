#!/bin/zsh

SENSOR="Core 0"
#SENSOR=TCXC
#SENSOR=k10temp

if [ -z "$1" ]; then
  echo -n "∆ "
fi
sensors | grep -A2 "$SENSOR" | grep -Po "\+[\d.]+°C" | head -n1 | sed 's/[\+°C]//g'
