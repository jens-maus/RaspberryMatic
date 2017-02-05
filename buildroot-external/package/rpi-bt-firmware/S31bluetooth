#! /bin/sh
### BEGIN INIT INFO
# Provides: bluetooth
# Required-Start:    $local_fs $syslog $remote_fs dbus
# Required-Stop:     $local_fs $syslog $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start bluetooth daemons
### END INIT INFO
#
# bluez    Bluetooth subsystem starting and stopping
#
# originally from bluez's scripts/bluetooth.init

PATH=/sbin:/bin:/usr/sbin:/usr/bin
DESC=bluetooth

DAEMON=/usr/libexec/bluetooth/bluetoothd
HCIATTACH=/usr/bin/hciattach
HCICONFIG=/usr/bin/hciconfig
SDPTOOL=/usr/bin/sdptool

SSD_OPTIONS="--oknodo --quiet --exec $DAEMON -- --compat"

test -f $DAEMON || exit 0


hci_attach()
{
	$HCIATTACH /dev/ttyAMA0 bcm43xx 921600 noflow-
	$HCICONFIG hci0 up	
}

case $1 in
  start)

	if test "$BLUETOOTH_ENABLED" = 0; then
		log_progress_msg "disabled. see /etc/default/bluetooth"
		log_end_msg 0
		exit 0
	fi

	hci_attach	
	
	start-stop-daemon --start --background $SSD_OPTIONS
	
  ;;
  stop)
	if test "$BLUETOOTH_ENABLED" = 0; then
		log_progress_msg "disabled."
		log_end_msg 0
		exit 0
	fi

	start-stop-daemon --stop $SSD_OPTIONS
  ;;
  restart|force-reload)
	$0 stop
	sleep 1
	$0 start
  ;;
  status)
	echo "$DAEMON" "$DESC" && exit 0 || exit $?
  ;;
  *)
	N=/etc/init.d/bluetooth
	echo "Usage: $N {start|stop|restart|force-reload|status}" >&2
	exit 1
	;;
esac

exit 0
