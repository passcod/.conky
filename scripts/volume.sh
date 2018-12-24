#!/usr/bin/bash
vol=$(amixer sget Master | grep 'Front Left: Playback' | grep -oP '(?<=\[)\d+')
echo -n $vol
#dc -e "$vol 100rdr%-n" 2>/dev/null
