#!/bin/zsh

helper='/usr/lib/gnome-settings-daemon/gsd-backlight-helper'
cur=$($helper --get-brightness)
max=$($helper --get-max-brightness)
per=$(dc -e "3k $cur $max /100*p")

if [[ -z "$1" ]]; then
  echo $per
else
  echo $per | cut -d. -f1
fi
