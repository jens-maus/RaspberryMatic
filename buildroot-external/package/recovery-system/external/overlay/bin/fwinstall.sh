#!/bin/sh

echo "Starting firmware update (DO NOT INTERRUPT!!!):<br/>"

# there can be only one!
if [[ -f /tmp/.runningFirmwareUpdate ]]; then
  echo "ERROR: Firmware Update already running"
  exit 1
fi

# capture on EXIT and create the lock file
trap 'rm -f /tmp/.runningFirmwareUpdate' EXIT
touch /tmp/.runningFirmwareUpdate

echo -ne "[1/4] Validate update directory... "
UPDATEDIR=$(readlink /usr/local/.firmwareUpdate)
if [[ -z "${UPDATEDIR}" ]] || [[ ! -d "${UPDATEDIR}" ]]; then
  echo "ERROR: (updatedir)"
  exit 1
fi
echo "OK<br/>"

# check for executable update_script in UPDATEDIR
echo -ne "[2/4] Checking update_script... "
if [[ -f "${UPDATEDIR}/update_script" ]]; then
  if [[ ! -x "${UPDATEDIR}/update_script" ]]; then
    echo "ERROR: update_script NOT executable"
    exit 1
  fi
  echo "exists, executing:<br/>"
  echo "================================================<br/>"

  # execute update_script
  (cd ${UPDATEDIR} ; ${UPDATEDIR}/update_script HM-RASPBERRYMATIC)
  if [[ $? -ne 0 ]]; then
    echo "================================================<br/>"
    echo "ERROR: update_script failed!"
    exit 1
  fi
  echo "================================================<br/>"

  # update script succeeded, lets finish immediately
  echo "DONE (succeeded)<br/>"
  exit 0
else
  echo "no 'update_script', OK<br/>"
fi

# check if there is an ext4 file waiting for us in UPDATEDIR
echo -ne "[3/4] Checking for rootfs filesystem images... "
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
      echo "ERROR: (blkid)"
      exit 1
    fi

    # get boot partition size in bytes
    ROOTFS_SIZE=$(/sbin/fdisk -l ${ROOTFS_DEV} | head -1 | cut -f5 -d" ")
    if [[ -z "${ROOTFS_SIZE}" ]]; then
      echo "ERROR: (fdisk)"
      exit 1
    fi

    # check if the found rootfs ext4 file matches the current rootfs partition size
    if [[ "${ROOTFS_SIZE}" != "$(stat -c%s ${ext4_file})" ]]; then
      echo "ERROR: rootfs partition has different size than provided image"
      exit 1
    fi

    # unmount /rootfs and flash the image using dd
    echo -ne "flashing... "
    umount -f /rootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (umount)"
      exit 1
    fi

    # use dd to write the image file to the boot partition
    /bin/dd if=${ext4_file} of=${ROOTFS_DEV} bs=1M conv=fsync status=none
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (dd)"
      exit 1
    fi

    mount /rootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (mount)"
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
echo -ne "[4/4] Checking for bootfs filesystem images... "
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
      echo "ERROR: (blkid)"
      exit 1
    fi

    # get boot partition size in bytes
    BOOTFS_SIZE=$(/sbin/fdisk -l ${BOOTFS_DEV} | head -1 | cut -f5 -d" ")
    if [[ -z "${BOOTFS_SIZE}" ]]; then
      echo "ERROR: (fdisk)"
      exit 1
    fi

    # check if the found bootfs vfat file matches the current bootfs partition size
    if [[ "${BOOTFS_SIZE}" != "$(stat -c%s ${vfat_file})" ]]; then
      echo "ERROR: bootfs partition has different size than provided image"
      exit 1
    fi

    # unmount /bootfs and flash the image using dd
    echo -ne "flashing... "
    umount -f /bootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (umount)"
      exit 1
    fi

    # use dd to write the image file to the boot partition
    /bin/dd if=${vfat_file} of=${BOOTFS_DEV} bs=1M conv=fsync status=none
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (dd)"
      exit 1
    fi

    mount /bootfs
    if [[ $? -ne 0 ]]; then
      echo "ERROR: (mount)"
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

echo "WARNING: no firmware update/recovery performed"
exit 1
