#!/usr/bin/bash
amixer sget Master | grep 'Front Left: Playback' | grep -oP '(?<=\[)\d+'
