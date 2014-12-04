#!/usr/bin/bash

disk="$1"
if [[ -z "$disk" ]]; then
  disk="/"
fi

df --output=pcent $disk | tail -n1 | tr -d '%'
