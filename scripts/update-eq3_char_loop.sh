#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a eq3_char_loop tag/commit id (see https://github.com/eq-3/occu)"
  exit 1
fi

sed -i "s/EQ3_CHAR_LOOP_VERSION = .*/EQ3_CHAR_LOOP_VERSION = $1/g" buildroot-external/package/eq3_char_loop/eq3_char_loop.mk
