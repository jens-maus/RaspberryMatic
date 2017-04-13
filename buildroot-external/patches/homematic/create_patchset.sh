#!/bin/sh
#
# This helper script will create/recreate our 0000-RaspberryMatic.patch
# patchset by generating diff output of orig<>real file differences in
# the "homematic" subfolder

origfiles=$(find homematic -name "*.orig" -type f -print)

rm -f 0000-RaspberryMatic.patch
for file in ${origfiles}; do
  diff -u ${file} ${file%.orig} >>0000-RaspberryMatic.patch
done
