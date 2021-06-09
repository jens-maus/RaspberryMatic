#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a Java Azul version (see https://www.azul.com/downloads/zulu-community/)"
  exit 1
fi

sed -i "s/JAVA_AZUL_VERSION = .*/JAVA_AZUL_VERSION = $1/g" buildroot-external/package/java-azul/java-azul.mk
