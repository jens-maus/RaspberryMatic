#!/bin/sh
#
# This script updates the /etc/config/localtime
# and /etc/timezone files according to the
# content of /etc/config/TZ
#

if [[ ! -s /etc/config/TZ ]]; then
  cp /etc/config_templates/TZ /etc/config/
fi

TZ=$(cat /etc/config/TZ)

case "${TZ}" in
  ACST-9:30)            TZ=Australia/North ;;
  ACST-9:30ACDT-10:30*) TZ=Australia/South ;;
  AEST-10)              TZ=Australia/Queensland ;;
  AEST-10AEDT-11*)      TZ=Australia/NSW ;;
  AKST+9AKDT+8*)        TZ=US/Alaska ;;
  AST+4ADT+3*)          TZ=Canada/Atlantic ;;
  AWST-8AWDT-9*)        TZ=Australia/West ;;
  BRST+3BRDT+2*)        TZ=Brazil/East ;;
  CET-1CEST-2*)         TZ=Europe/Berlin ;;
  CST+6)                TZ=America/Costa_Rica ;;
  CST+6CDT+5*)          TZ=US/Central ;;
  EET-2EEST-3*)         TZ=EET ;;
  EST+5EDT+4*)          TZ=US/Eastern ;;
  GMT+0BST-1*)          TZ=Europe/London ;;
  GMT+0IST-1*)          TZ=Europe/Dublin ;;
  HAW+10)               TZ=Pacific/Honolulu ;;
  HKT-8)                TZ=Asia/Hong_Kong ;;
  MSK-3MSD-4*)          TZ=Europe/Moscow ;;
  RMST-3RMDT-4*)        TZ=Europe/Moscow ;;
  MST+7)                TZ=MST ;;
  MST+7MDT+6*)          TZ=MST7MDT ;;
  NST+3:30NDT+2:30*)    TZ=Canada/Newfoundland ;;
  NZST-12NZDT-13*)      TZ=Pacific/Auckland ;;
  PST+8PDT+7*)          TZ=Canada/Pacific ;;
  SGT-8)                TZ=Asia/Singapore ;;
  ULAT-8ULAST-9*)       TZ=Asia/Ulan_Bator ;;
  WET-0WEST-1*)         TZ=WET ;;
  WIB-7)                TZ=Asia/Jakarta ;;
esac

# fallback to Europe/Berlin
if [[ -z "${TZ}" ]] ||
   [[ ! -e "/usr/share/zoneinfo/${TZ}" ]]; then
  TZ=Europe/Berlin
  cp /etc/config_templates/TZ /etc/config/TZ
fi

# update /etc/config/localtime and /etc/config/timezone
if [[ "$(readlink /etc/config/localtime)" != "/usr/share/zoneinfo/${TZ}" ]] ||
   [[ "$(cat /etc/config/timezone 2>/dev/null)" != "${TZ}" ]]; then
  rm -f /etc/config/localtime
  ln -s /usr/share/zoneinfo/${TZ} /etc/config/localtime
  echo ${TZ} >/etc/config/timezone
fi
