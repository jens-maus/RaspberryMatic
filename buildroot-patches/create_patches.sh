#!/bin/bash
#
# This helper script will create/recreate our 0000-XXXXXX.patch
# patchset files by generating diff output of orig<>real file differences in
# all the 0000-XXXX folders

patchdirs=$(find buildroot/package -maxdepth 1 -type d | sort)

#rm *.patch

COUNTER=1
for dir in ${patchdirs}; do
  package=$(basename ${dir})
  [[ "${package}" == "package" ]] && continue
  count=$(printf %04d ${COUNTER})
  patchfile=${count}-${package}.patch
  echo ${patchfile}
  origfiles=$(find ${dir} -name "*.orig" -type f -print | sort)
  rm -f ${patchfile}
  for file in ${origfiles}; do
    diff -u --label=${file} --label=${file%.orig} ${file} ${file%.orig} >>${patchfile}
  done
  COUNTER=$((COUNTER+1))
done
