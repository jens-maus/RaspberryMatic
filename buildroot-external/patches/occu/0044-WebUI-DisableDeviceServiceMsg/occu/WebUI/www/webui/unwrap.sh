#!/bin/sh
#
# helper script to wrap/unwrap the webui.js file depending on the \n newline markers
#

if [ "$1" = "-w" ]; then
  shift
  # wrap
  sed ':a;N;$!ba;s/\\n\n/\\n/g' "$1"
else
  # unwrap
  sed '1,10s/\\n/\\n\n/g' "$1"
fi
