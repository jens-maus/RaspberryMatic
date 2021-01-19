#!/bin/sh
# shellcheck shell=dash disable=SC2169

PIUPSMON_LOG=/var/log/piupsmon.log
STATUS_CHANGE=$(grep "Status changed from" ${PIUPSMON_LOG} | tail -1 ${PIUPSMON_LOG} | sed -n 's/.* Status changed from \(.\) .* to \(.\) .*/\1 \2/p')
if [[ -n "${STATUS_CHANGE}" ]]; then
  #STATUS_FROM=$(echo "${STATUS_CHANGE}" | cut -d' ' -f1)
  STATUS_TO=$(echo "${STATUS_CHANGE}" | cut -d' ' -f2)
  MESSAGE=

  case "${STATUS_TO}" in
    1)
      MESSAGE="Battery Fully Charged"
    ;;

    2)
      MESSAGE="Power Loss"
    ;;

    5)
      MESSAGE="Battery Disconnected"
    ;;

    9)
      MESSAGE="Power Restored"
    ;;
  esac

  if [[ -n "${MESSAGE}" ]]; then
    /bin/triggerAlarm.tcl "${MESSAGE}" "PiUSV-Alarm"
  fi
fi
