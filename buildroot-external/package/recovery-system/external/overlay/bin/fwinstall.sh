#!/bin/sh

echo Entering firmware update mode
echo primary > /sys/module/plat_eq3ccu2/parameters/boot        

#if [ ! -f /var/new_firmware.tar.gz ]; then
#        echo "Firmware image archive does not exist. Rebooting"
#        # echo x > /dev/watchdog
#        # /sbin/reboot
#        # while true ; do true ;  done
#	exit
#fi

#echo Extract firmware update file ...

cd /var

#cat new_firmware.tar.gz | gunzip | tar x

if [ ! -x /var/update_script ]; then
        echo "Error in firmware image archive. Rebooting"
        # echo x > /dev/watchdog
	/sbin/reboot
        #while true ; do true ;  done
        exit
fi

#rm new_firmware.tar.gz

ubidetach -p /dev/mtd7
/var/update_script CCU2

echo "Update installed. Rebooting"
/sbin/reboot

