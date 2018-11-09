#!/bin/sh
#
# Tiny wrapper script walking through our subdirectories containing
# "logo.png" files and generating the corresponding patch files in
# the same subdirectory.
#
# This tool requires "gdk-pixbuf-csource" from libgtk
#

logofiles=$(find . -maxdepth 2 -type f -name logo.png -print0)
for file in ${logofiles}; do
  dir=$(dirname ${file})
  gdk-pixbuf-csource --macros --name=POKY_IMG ${dir}/logo.png | sed 's/guint8/uint8/g' >/tmp/psplash-poky-img.h
  diff -u --label=psplash/psplash-poky-img.h.orig --label=psplash/psplash-poky-img.h psplash-poky-img.h.orig /tmp/psplash-poky-img.h >${dir}/0001-logo.patch
  rm -f /tmp/psplash-poky-img.h
done
