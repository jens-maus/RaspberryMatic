#!/bin/sh
#
# This helper script will walk over all patchfiles and identify old files
# based on the content of the upstream (occu) files

patchdirs=$(find . -maxdepth 1 -type d -regex "\\./[0-9][0-9][0-9][0-9]-.*" | sort)

for dir in ${patchdirs}; do
  (
    cd "${dir}" || exit 1
    origfiles=$(find occu -name "*.orig" -type f -print | sort)
    for file in ${origfiles}; do
      echo "${file}"
      #diff -u --label=${file} --label=${file%.orig} ${file} ${file%.orig} >>../${dir}.patch
    done
  )
done
