#!/bin/sh

echo "Starting firmware update (DO NOT INTERRUPT!!!):<br/>"

# there can be only one!
if [[ -f /tmp/.runningFirmwareUpdate ]]; then
  echo "ERROR: Firmware Update already running<br/>"
  exit 1
fi

# capture on EXIT and create the lock file
trap 'rm -f /tmp/.runningFirmwareUpdate' EXIT
touch /tmp/.runningFirmwareUpdate

echo -ne "[1] Validate update directory... "
UPDATEDIR=$(readlink /usr/local/.firmwareUpdate)
if [[ -z "${UPDATEDIR}" ]] || [[ ! -d "${UPDATEDIR}" ]]; then
  echo "ERROR: (updatedir)<br/>"
  exit 1
fi
echo "OK<br/>"

# check for executable update_script in UPDATEDIR
echo -ne "[2] Checking update_script... "
if [[ -f "${UPDATEDIR}/update_script" ]]; then
  if [[ ! -x "${UPDATEDIR}/update_script" ]]; then
    echo "ERROR: update_script NOT executable<br/>"
    exit 1
  fi
  echo "exists, executing:<br/>"
  echo "================================================<br/>"

  # execute update_script
  (cd ${UPDATEDIR}; ${UPDATEDIR}/update_script HM-RASPBERRYMATIC)
  if [[ $? -ne 0 ]]; then
    echo "<br/>================================================<br/>"
    echo "ERROR: update_script failed!<br/>"
    exit 1
  fi
  echo "<br/>================================================<br/>"

  # update script succeeded, lets finish immediately
  echo "DONE (succeeded)<br/>"
  exit 0
else
  echo "no 'update_script', OK<br/>"
fi

# check if there is an ext4 file waiting for us in UPDATEDIR
echo -ne "[3] Checking for rootfs filesystem images... "
FLASHED_ROOTFS=0
for ext4_file in ${UPDATEDIR}/*.ext4; do
  [[ -f ${ext4_file} ]] || break

  # lets see if this is rootfs
  file -b ${ext4_file} | egrep -q "ext4 filesystem.*rootfs"
  if [[ $? -eq 0 ]]; then
    echo -ne "found ($(basename ${ext4_file})), "

    # make sure rootfs is mounted
    mount /rootfs >/dev/null 2>&1

    # find out the rootfs device node
    ROOTFS_DEV=$(/sbin/blkid | grep rootfs | cut -f1 -d:)
    if [[ -z "${ROOTFS_DEV}" ]]; then
      echo "ERROR: (blkid)<br/>"
      exit 1
    fi

    # get boot partition size in bytes
    ROOTFS_SIZE=$(/sbin/fdisk -l ${ROOTFS_DEV} | head -1 | cut -f5 -d" ")
    if [[ -z "${ROOTFS_SIZE}" ]]; then
      echo "ERROR: (fdisk)<br/>"
      exit 1
    fi

    # check if the found rootfs ext4 file matches the current rootfs partition size
    if [[ "${ROOTFS_SIZE}" != "$(stat -c%s ${ext4_file})" ]]; then
      echo "ERROR: rootfs partition has different size than provided image<br/>"
      exit 1
    fi

    # unmount /rootfs and flash the image using dd
    echo -ne "flashing.."
    umount -f /rootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (umount)<br/>"
      exit 1
    fi

    # start a progress bar outputing dots every few seconds
    while :;do echo -n .;sleep 3;done &
    PROGRESS_PID=$!
    trap "kill ${PROGRESS_PID}" EXIT

    # use dd to write the image file to the boot partition
    /bin/dd if=${ext4_file} of=${ROOTFS_DEV} bs=1M conv=fsync status=none
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (dd)<br/>"
      exit 1
    fi

    # stop the progress output
    kill ${PROGRESS_PID} && trap " " EXIT

    mount /rootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (mount)<br/>"
      exit 1
    fi

    echo "OK<br/>"

    FLASHED_ROOTFS=1
    break
  fi

done
if [[ ${FLASHED_ROOTFS} -eq 0 ]]; then
  echo "none found, OK<br/>"
fi

# check if there is an vfat file waiting for us in UPDATEDIR
echo -ne "[4] Checking for bootfs filesystem images... "
FLASHED_BOOTFS=0
for vfat_file in ${UPDATEDIR}/*.vfat; do
  [[ -f ${vfat_file} ]] || break

  # lets see if this is bootfs
  file -b ${vfat_file} | egrep -q "DOS/MBR boot sector.*mkfs.fat.*bootfs.*FAT"
  if [[ $? -eq 0 ]]; then
    echo -ne "found ($(basename ${vfat_file})), "

    # make sure bootfs is mounted
    mount /bootfs >/dev/null 2>&1

    # find out the bootfs device node
    BOOTFS_DEV=$(/sbin/blkid | grep bootfs | cut -f1 -d:)
    if [[ -z "${BOOTFS_DEV}" ]]; then
      echo "ERROR: (blkid)<br/>"
      exit 1
    fi

    # get boot partition size in bytes
    BOOTFS_SIZE=$(/sbin/fdisk -l ${BOOTFS_DEV} | head -1 | cut -f5 -d" ")
    if [[ -z "${BOOTFS_SIZE}" ]]; then
      echo "ERROR: (fdisk)<br/>"
      exit 1
    fi

    # check if the found bootfs vfat file matches the current bootfs partition size
    if [[ "${BOOTFS_SIZE}" != "$(stat -c%s ${vfat_file})" ]]; then
      echo "ERROR: bootfs partition has different size than provided image<br/>"
      exit 1
    fi

    # unmount /bootfs and flash the image using dd
    echo -ne "flashing.."
    umount -f /bootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (umount)<br/>"
      exit 1
    fi

    # start a progress bar outputing dots every few seconds
    while :;do echo -n .;sleep 3;done &
    PROGRESS_PID=$!
    trap "kill ${PROGRESS_PID}" EXIT

    # use dd to write the image file to the boot partition
    /bin/dd if=${vfat_file} of=${BOOTFS_DEV} bs=1M conv=fsync status=none
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (dd)<br/>"
      exit 1
    fi

    # stop the progress output
    kill ${PROGRESS_PID} && trap " " EXIT

    mount /bootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (mount)<br/>"
      exit 1
    fi

    echo "OK<br/>"

    FLASHED_BOOTFS=1
    break
  fi
done
if [[ ${FLASHED_BOOTFS} -eq 0 ]]; then
  echo "none found, OK<br/>"
fi

# if we flashed either rootfs or bootfs we are finished
if [[ ${FLASHED_ROOTFS} -eq 1 ]] || [[ ${FLASHED_BOOTFS} -eq 1 ]]; then
  exit 0
fi

######
# check for a full-fledged sdcard image in update dir
echo -ne "[5] Checking for sdcard image... "
FLASHED_IMG=0
for img_file in ${UPDATEDIR}/*.img; do
  [[ -f ${img_file} ]] || break

  echo -ne "found, "

  # find out which will be the next lofs device node
  LOFS_DEV=$(/sbin/losetup -f)

  # perform a lofs mount of the image file
  /sbin/losetup -r -f -P ${img_file}
  if [[ $? -ne 0 ]]; then
    echo "ERROR: (losetup)<br/>"
    exit 1
  fi

  # find out the bootfs loop device node
  BOOTFS_LOOPDEV=$(/sbin/blkid | egrep "${LOFS_DEV}.*bootfs" | cut -f1 -d:)
  if [[ -n "${BOOTFS_LOOPDEV}" ]]; then
    # found out the bootfs main device
    BOOTFS_DEV=$(/sbin/blkid | grep -v "${LOFS_DEV}" | grep bootfs | cut -f1 -d:)
    if [[ -z "${BOOTFS_DEV}" ]]; then
      echo "ERROR: (blkid bootfs)<br/>"
      exit 1
    fi

    # get boot partition size in bytes
    BOOTFS_SIZE=$(/sbin/fdisk -l ${BOOTFS_DEV} | head -1 | cut -f5 -d" ")
    if [[ -z "${BOOTFS_SIZE}" ]]; then
      echo "ERROR: (fdisk bootfs)<br/>"
      exit 1
    fi

    # get boot lofs partition size in bytes
    BOOTFS_LOOPSIZE=$(/sbin/fdisk -l ${BOOTFS_LOOPDEV} | head -1 | cut -f5 -d" ")
    if [[ -z "${BOOTFS_LOOPSIZE}" ]]; then
      echo "ERROR: (fdisk bootfs loopfs)<br/>"
      exit 1
    fi

    # check if the found bootfs loopfs size matches the current bootfs partition size
    if [[ "${BOOTFS_SIZE}" != "${BOOTFS_LOOPSIZE}" ]]; then
      echo "ERROR: bootfs partition has different size than provided image<br/>"
      exit 1
    fi

    # unmount /bootfs and flash the image using dd
    echo -ne "flashing bootfs.."
    umount -f /bootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (umount)<br/>"
      exit 1
    fi

    # start a progress bar outputing dots every few seconds
    while :;do echo -n .;sleep 3;done &
    PROGRESS_PID=$!
    trap "kill ${PROGRESS_PID}" EXIT

    # use dd to write the image file to the boot partition
    /bin/dd if=${BOOTFS_LOOPDEV} of=${BOOTFS_DEV} bs=1M conv=fsync status=none
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (dd)<br/>"
      exit 1
    fi

    # stop the progress output
    kill ${PROGRESS_PID} && trap " " EXIT

    mount -o ro ${BOOTFS_DEV} /bootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (mount)<br/>"
      exit 1
    fi

    echo -ne "OK, "

  fi

  # find out the rootfs loop device node
  ROOTFS_LOOPDEV=$(/sbin/blkid | egrep "${LOFS_DEV}.*rootfs" | cut -f1 -d:)
  if [[ -n "${ROOTFS_LOOPDEV}" ]]; then
    # found out the rootfs main device
    ROOTFS_DEV=$(/sbin/blkid | grep -v "${LOFS_DEV}" | grep rootfs | cut -f1 -d:)
    if [[ -z "${ROOTFS_DEV}" ]]; then
      echo "ERROR: (blkid rootfs)<br/>"
      exit 1
    fi

    # get root partition size in bytes
    ROOTFS_SIZE=$(/sbin/fdisk -l ${ROOTFS_DEV} | head -1 | cut -f5 -d" ")
    if [[ -z "${ROOTFS_SIZE}" ]]; then
      echo "ERROR: (fdisk rootfs)<br/>"
      exit 1
    fi

    # get root lofs partition size in bytes
    ROOTFS_LOOPSIZE=$(/sbin/fdisk -l ${ROOTFS_LOOPDEV} | head -1 | cut -f5 -d" ")
    if [[ -z "${ROOTFS_LOOPSIZE}" ]]; then
      echo "ERROR: (fdisk rootfs loopfs)<br/>"
      exit 1
    fi

    # check if the found rootfs loopfs size matches the current rootfs partition size
    if [[ "${ROOTFS_SIZE}" != "${ROOTFS_LOOPSIZE}" ]]; then
      echo "ERROR: rootfs partition has different size than provided image<br/>"
      exit 1
    fi

    # unmount /rootfs and flash the image using dd
    echo -ne "flashing rootfs.."
    umount -f /rootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (umount)<br/>"
      exit 1
    fi

    # start a progress bar outputing dots every few seconds
    while :;do echo -n .;sleep 3;done &
    PROGRESS_PID=$!
    trap "kill ${PROGRESS_PID}" EXIT

    # use dd to write the image file to the boot partition
    /bin/dd if=${ROOTFS_LOOPDEV} of=${ROOTFS_DEV} bs=1M conv=fsync status=none
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (dd)<br/>"
      exit 1
    fi

    # stop the progress output
    kill ${PROGRESS_PID} && trap " " EXIT

    mount -o ro ${ROOTFS_DEV} /rootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (mount)<br/>"
      exit 1
    fi

    echo -ne "OK, "

  fi

  # detach all lofs devices
  /sbin/losetup -d ${LOFS_DEV}
  if [[ $? -ne 0 ]]; then
    echo "ERROR: (lofs detach)<br/>"
    exit 1
  fi

  echo "DONE<br/>"

  FLASHED_IMG=1
  break
done
if [[ ${FLASHED_IMG} -eq 0 ]]; then
  echo "none found, OK<br/>"
else
  exit 0
fi

echo "<br/>"
echo "WARNING: no firmware update/recovery performed<br/>"
exit 1
