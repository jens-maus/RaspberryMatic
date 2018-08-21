#!/bin/sh

pathBackup=$1

# This log is for debugging only
echo $pathBackup > /tmp/bckPath.log
/opt/java/bin/java -Dgnu.io.rxtx.SerialPorts=/dev/mmd_hmip -cp /opt/HMServer/HMIPServer.jar de.eq3.ccu.server.ip.validation.ValidateHmIPBackup /etc/crRFD.conf $pathBackup

case $? in
 -1) exitCode=9 ;;
  0) exitCode=10 ;;
  1) exitCode=11 ;;
  2) exitCode=12 ;;
  3) exitCode=13 ;;
  4) exitCode=14 ;;
  5) exitCode=15 ;;
  6) exitCode=16 ;;
  7) exitCode=17 ;;
  8) exitCode=18 ;;
  *) exitCode=99 ;;
esac

# Important - don't delete the echo output - backupStatus.log is necessary for determining the error code of the above java application.
echo $exitCode > /tmp/backupStatus.log
exit $exitCode
