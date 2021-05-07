#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a Buildroot version (see https://buildroot.org)"
  exit 1
fi

sed -i "s/BUILDROOT_VERSION=.*/BUILDROOT_VERSION=$1/g" Makefile
