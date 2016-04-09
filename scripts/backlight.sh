#!/bin/zsh

helper='/usr/lib/gnome-settings-daemon/gsd-backlight-helper'
cur=$($helper --get-brightness)
max=$($helper --get-max-brightness)
per=$(dc -e "3k $cur $max /100*p")

if [[ -z "$1" ]]; then
  echo $per | cut -c-2
else
  echo $per | cut -c-4
fi
