#!/bin/sh
#
# This helper script will create/recreate our 0000-XXXXXX.patch
# patchset files by generating diff output of orig<>real file differences in
# all the 0000-XXXX folders

set -e

export LC_ALL=C

patchdirs=$(find . -maxdepth 1 -type d -regex "\\./[0-9][0-9][0-9][0-9]-.*" | sort)

rm -f ./*.patch

for dir in ${patchdirs}; do
  (
    cd "${dir}" || exit 1
    echo $(basename ${dir})
    origfiles=$(find occu -name "*.orig" -type f -print | sort)
    if [ -z "${origfiles}" ]; then
      exit 1
    fi
    rm -f "../${dir}.patch"
    for file in ${origfiles}; do
      diff -u --label="${file}" --label="${file%.orig}" "${file}" "${file%.orig}" >>"../${dir}.patch" || true
    done
  )
done

exit 0
