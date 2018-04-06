#!/bin/sh

printInfo () {
	local currentSystem=`getCurrentSystem`
	echo "<Info> Current sytem is ${currentSystem}"
}

set -o pipefail

case "$1" in
  info)	printInfo
	exit 0
	;;
  *)
	echo "<Info> Upload image..."
	#cat 1> /var/new_firmware.tar.gz
	cd /var
	gunzip | tar x
	echo "done."
	/bin/fwinstall.sh
	;;
esac

if [ $? -eq 0 ]; then
	echo "<Info> Update successfully completed"
	return 0
else
	echo "<Error> Update failed"
	return 1
fi
