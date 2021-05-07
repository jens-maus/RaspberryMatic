#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a generic_raw_uart commitID (see https://github.com/alexreinert/piVCCU/tree/master/kernel)"
  exit 1
fi

sed -i "s/GENERIC_RAW_UART_VERSION = .*/GENERIC_RAW_UART_VERSION = $1/g" buildroot-external/package/generic_raw_uart/generic_raw_uart.mk
