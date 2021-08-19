#!/bin/sh
# shellcheck shell=dash disable=SC3010

jsonfile=/tmp/addon_updates.json
if [[ -n "$(ls -A /etc/config/rc.d)" ]]; then
  echo "[" > $jsonfile
  first=1
  for filename in /etc/config/rc.d/*; do
    if [[ -f $filename ]]; then
      DINFO=$($filename info)
      DNAME=$(echo "$DINFO" | grep "Name: " | sed "s/Name: //g")
      DVERSION=$(echo "$DINFO" | grep "Version:" | awk '{print $2}')
      DUPDATESCRIPT=$(echo "$DINFO" | grep "Update:" | awk '{print $2}')
      if [[ -n "${DUPDATESCRIPT}" ]]; then
        QUERY_STRING="cmd=check_version\&version=${DVERSION}"
        WEBRESULT=$(export QUERY_STRING=${QUERY_STRING}; tclsh "/www${DUPDATESCRIPT}" | grep "\.")
        if [[ "$first" -eq 1 ]]; then
          first=0
        else
          echo "," >> $jsonfile
        fi
        echo "{\"name\":\"$DNAME\",\"webversion\":\"$WEBRESULT\"}" >> $jsonfile
        if [[ "$DVERSION" != "$WEBRESULT" ]]; then
          echo "Update available for $DNAME ($DVERSION / $WEBRESULT)"
        fi
      fi
    fi
  done
  echo "]" >> $jsonfile
else
  [[ -f $jsonfile ]] && rm $jsonfile
fi
