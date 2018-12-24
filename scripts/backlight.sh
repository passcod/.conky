#!/bin/zsh

device='/sys/class/backlight/intel_backlight/'
cur=$(cat $device/actual_brightness)
max=$(cat $device/max_brightness)
per=$(dc -e "3k $cur $max /100*p")

if [[ -z "$1" ]]; then
  echo $per
else
  echo $per | cut -d. -f1
fi
