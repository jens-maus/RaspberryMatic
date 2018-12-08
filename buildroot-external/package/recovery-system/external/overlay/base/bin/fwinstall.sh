#!/bin/sh
#
# General purpose shell script to prepare and install a firmware update
# either archived or unarchived, verifies its validity and installs it
# unattended accordingly.
#
# Copyright (c) 2018 Jens Maus <mail@jens-maus.de>
# Apache 2.0 License applies
#

######
# function that is called with the filename containing
# the firmware update either archived or unarchived.
fwprepare()
{
  filename=${1}

  # output the number of bytes received
  echo "$(stat -c%s ${filename}) bytes received.<br/>"

  echo -ne "[2/5] Calculating SHA256 checksum: "
  CHKSUM=$(/usr/bin/sha256sum ${filename})
  if [ $? -ne 0 ]; then
    echo "ERROR (sha256sum)"
    exit 1
  fi
  echo "$(echo ${CHKSUM} | awk '{ print $1 }')<br/>"

  ########
  # check if file is a valid firmware update/recovery file
  echo -ne "[3/5] Checking uploaded data... "

  TMPDIR="${filename}-dir"
  mkdir -p "${TMPDIR}"
  if [ $? -ne 0 ]; then
    echo "ERROR: (mkdir tmpdir)"
    exit 1
  fi

  FILETYPE=""

  # check for tar.gz or .tar
  if [ -z "${FILETYPE}" ]; then
    /usr/bin/file -b ${filename} | egrep -q "(gzip compressed|tar archive)"
    if [ $? -eq 0 ]; then
      echo -ne "tar identified, unarchiving.."

      # start a progress bar outputing dots every few seconds
      while :;do echo -n .;sleep 3;done &
      PROGRESS_PID=$!
      trap "kill ${PROGRESS_PID}; rm -f /tmp/.runningFirmwareUpdate" EXIT

      # unarchive the tar
      /bin/tar -C ${TMPDIR} --no-same-owner -xf ${filename}
      if [ $? -ne 0 ]; then
        echo "ERROR: (untar)"
        exit 1
      fi

      # stop the progress output
      kill ${PROGRESS_PID} && trap "rm -f /tmp/.runningFirmwareUpdate" EXIT

      rm -f ${filename}

      FILETYPE="tar"
    fi
  fi

  # check for .zip
  if [ -z "${FILETYPE}" ]; then
    /usr/bin/file -b ${filename} | grep -q "Zip archive data"
    if [ $? -eq 0 ]; then
      echo -ne "zip identified, unarchiving.."

      # start a progress bar outputing dots every few seconds
      while :;do echo -n .;sleep 3;done &
      PROGRESS_PID=$!
      trap "kill ${PROGRESS_PID}; rm -f /tmp/.runningFirmwareUpdate" EXIT

      # unarchive the zip
      /usr/bin/unzip -q -o -d ${TMPDIR} ${filename} 2>/dev/null
      if [ $? -ne 0 ]; then
        echo "ERROR: (unzip)"
        exit 1
      fi

      # stop the progress output
      kill ${PROGRESS_PID} && trap "rm -f /tmp/.runningFirmwareUpdate" EXIT

      rm -f ${filename}

      FILETYPE="zip"
    fi
  fi

  # check for .img
  if [ -z "${FILETYPE}" ]; then
    /usr/bin/file -b ${filename} | egrep -q "DOS/MBR boot sector.*partition 3"
    if [ $? -eq 0 ]; then
      echo -ne "sdcard img identified, validating, "

      # the file seems to be a full-fledged SD card image with MBR boot sector, etc. so lets
      # check if we have exactly 3 partitions
      /usr/sbin/parted -sm ${filename} print 2>/dev/null | tail -1 | egrep -q "3:.*:ext4:"
      if [ $? -ne 0 ]; then
        echo "ERROR: (parted)"
        exit 1
      fi

      mv -f ${filename} ${TMPDIR}/new_firmware.img

      FILETYPE="img"
    fi
  fi

  # check for ext4 rootfs filesystem
  if [ -z "${FILETYPE}" ]; then
    /usr/bin/file -b ${filename} | egrep -q "ext4 filesystem.*rootfs"
    if [ $? -eq 0 ]; then
      echo -ne "rootfs ext4 identified, validating, "

      # the file seems to be an ext4 fs of the rootfs lets check if the ext4 is valid
      /sbin/e2fsck -nf ${filename} 2>/dev/null >/dev/null
      if [ $? -ne 0 ]; then
        echo "ERROR: (e2fsck)"
        exit 1
      fi

      mv -f ${filename} ${TMPDIR}/rootfs.ext4

      FILETYPE="ext4"
    fi
  fi

  # check for vfat bootfs filesystem
  if [ -z "${FILETYPE}" ]; then
    /usr/bin/file -b ${filename} | egrep -q "DOS/MBR boot sector.*bootfs.*FAT"
    if [ $? -eq 0 ]; then
      echo -ne "bootfs vfat identified, validating, "

      # the file seems to be a vfat fs of the bootfs lets check if the ext4 is valid
      #/sbin/fsck.fat -nf ${filename} 2>/dev/null >/dev/null
      #if [ $? -ne 0 ]; then
      #  echo "ERROR: (fsck.fat)"
      #  exit 1
      #fi

      mv -f ${filename} ${TMPDIR}/bootfs.vfat

      FILETYPE="vfat"
    fi
  fi

  if [ -z "${FILETYPE}" ]; then
    echo "ERROR: no valid filetype found"
    exit 1
  else
    echo "OK<br/>"
  fi

  ######
  # now we have unarchived everyting to TMPDIR, so lets check if it is valid
  echo -ne "[4/5] Verifying checksums... "

  # check for sha256 checksums
  (cd ${TMPDIR};
    for chk_file in *.sha256; do
      [ -f "${chk_file}" ] || break
      /usr/bin/sha256sum -sc ${chk_file}
      if [ $? -ne 0 ]; then
        echo "ERROR: (sha256sum)"
        exit 1
      else
        echo -ne "OK (sha256sum), "
      fi
    done
  ) || exit 1

  # check for md5 checksums
  (cd ${TMPDIR};
    for chk_file in *.md5; do
      [ -f "${chk_file}" ] || break
      /usr/bin/md5sum -sc ${chk_file}
      if [ $? -ne 0 ]; then
        echo "ERROR: (md5sum)"
        exit 1
      else
        echo -ne "OK (md5sum), "
      fi
    done
  ) || exit 1

  echo "DONE<br>"

  ######
  # now we check if update_script is required and found and if so we
  # flag this firmware update accordingly
  echo -ne "[5/5] Preparing firmware update... "

  if ! ls ${TMPDIR}/*.img >/dev/null 2>&1 &&
     ! ls ${TMPDIR}/*.ext4 >/dev/null 2>&1 &&
     ! ls ${TMPDIR}/*.vfat >/dev/null 2>&1; then
    if [ ! -x "${TMPDIR}/update_script" ]; then
      echo "ERROR: (update_script)"
      exit 1
    fi

    echo "OK (update_script found), "
  fi

  ln -sf ${TMPDIR} /usr/local/.firmwareUpdate
  if [ $? -ne 0 ]; then
    echo "ERROR: (ln)"
    exit 1
  fi

  echo "DONE<br/>"
  echo "<br/>"
}

######
# function that is performing the unattended firmware update by
# checking if there is an /usr/local/.firmwareUpdate link to the
# directory containing the update files
fwinstall()
{
  echo -ne "[1/5] Validate update directory... "
  UPDATEDIR=$(readlink -f /usr/local/.firmwareUpdate)
  if [[ -z "${UPDATEDIR}" ]] || [[ ! -d "${UPDATEDIR}" ]]; then
    echo "ERROR: (updatedir)<br/>"
    exit 1
  fi
  echo "OK<br/>"

  # check for executable update_script in UPDATEDIR
  echo -ne "[2/5] Checking update_script... "
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
    return 0
  else
    echo "no 'update_script', OK<br/>"
  fi

  # check if there is an ext4 file waiting for us in UPDATEDIR
  echo -ne "[3/5] Checking for rootfs filesystem images... "
  FLASHED_ROOTFS=0
  for ext4_file in ${UPDATEDIR}/*.ext4; do
    [[ -f ${ext4_file} ]] || break

    # lets see if this is rootfs
    file -b ${ext4_file} | egrep -q "ext4 filesystem.*rootfs"
    if [[ $? -eq 0 ]]; then
      echo -ne "found ($(basename ${ext4_file})), "

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

      # find out if the hardware platform of the current rootfs and the one
      # we are going to flash are the same
      ROOTFS_PLATFORM=$(cat /VERSION | grep PLATFORM= | cut -d= -f2)
      if [[ -z "${ROOTFS_PLATFORM}" ]]; then
        echo "ERROR: (ROOTFS_PLATFORM)<br/>"
        exit 1
      fi

      # mount fs readonly
      mount -o ro,loop ${ext4_file} /mnt
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (lo mount)<br/>"
        exit 1
      fi

      # get platform info in image file
      IMG_PLATFORM=$(cat /mnt/VERSION | grep PLATFORM= | cut -d= -f2)

      # unmount immediately
      umount -f /mnt
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (umount /mnt)<br/>"
        exit 1
      fi

      # check if plaform is non-empty
      if [[ -z "${IMG_PLATFORM}" ]]; then
        echo "ERROR: (IMG_PLATFORM)<br/>"
        exit 1
      fi

      # check if both PLATFORM match
      if [[ "${ROOTFS_PLATFORM}" != "${IMG_PLATFORM}" ]]; then
        echo "ERROR: incorrect hardware platform (${IMG_PLATFORM} != ${ROOTFS_PLATFORM})<br/>"
        exit 1
      fi

      # unmount /rootfs and flash the image using dd
      echo -ne "flashing.."
      umount -f ${ROOTFS_DEV}

      # start a progress bar outputing dots every few seconds
      while :;do echo -n .;sleep 3;done &
      PROGRESS_PID=$!
      trap "kill ${PROGRESS_PID}; rm -f /tmp/.runningFirmwareUpdate" EXIT

      # use dd to write the image file to the boot partition
      /bin/dd if=${ext4_file} of=${ROOTFS_DEV} bs=4M conv=fsync status=none
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (dd)<br/>"
        exit 1
      fi

      # stop the progress output
      kill ${PROGRESS_PID} && trap "rm -f /tmp/.runningFirmwareUpdate" EXIT

      mount -o ro ${ROOTFS_DEV} /rootfs
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
  echo -ne "[4/5] Checking for bootfs filesystem images... "
  FLASHED_BOOTFS=0
  for vfat_file in ${UPDATEDIR}/*.vfat; do
    [[ -f ${vfat_file} ]] || break

    # lets see if this is bootfs
    file -b ${vfat_file} | egrep -q "DOS/MBR boot sector.*mkfs.fat.*bootfs.*FAT"
    if [[ $? -eq 0 ]]; then
      echo -ne "found ($(basename ${vfat_file})), "

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

      # find out if the hardware platform of the current rootfs and the one
      # we are going to flash are the same
      BOOTFS_PLATFORM=$(cat /VERSION | grep PLATFORM= | cut -d= -f2)
      if [[ -z "${BOOTFS_PLATFORM}" ]]; then
        echo "ERROR: (BOOTFS_PLATFORM)<br/>"
        exit 1
      fi

      # mount fs readonly
      mount -o ro,loop ${vfat_file} /mnt
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (lo mount)<br/>"
        exit 1
      fi

      # get platform info in image file
      IMG_PLATFORM=$(cat /mnt/VERSION | grep PLATFORM= | cut -d= -f2)

      # unmount immediately
      umount -f /mnt
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (umount /mnt)<br/>"
        exit 1
      fi

      # check if plaform is non-empty
      if [[ -z "${IMG_PLATFORM}" ]]; then
        echo "ERROR: (IMG_PLATFORM)<br/>"
        exit 1
      fi

      # check if both PLATFORM match
      if [[ "${BOOTFS_PLATFORM}" != "${IMG_PLATFORM}" ]]; then
        echo "ERROR: incorrect hardware platform (${IMG_PLATFORM} != ${BOOTFS_PLATFORM})<br/>"
        exit 1
      fi

      # unmount /bootfs and flash the image using dd
      echo -ne "flashing.."
      umount -f ${BOOTFS_DEV}

      # start a progress bar outputing dots every few seconds
      while :;do echo -n .;sleep 3;done &
      PROGRESS_PID=$!
      trap "kill ${PROGRESS_PID}; rm -f /tmp/.runningFirmwareUpdate" EXIT

      # use dd to write the image file to the boot partition
      /bin/dd if=${vfat_file} of=${BOOTFS_DEV} bs=4M conv=fsync status=none
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (dd)<br/>"
        exit 1
      fi

      # stop the progress output
      kill ${PROGRESS_PID} && trap "rm -f /tmp/.runningFirmwareUpdate" EXIT

      mount -o ro ${BOOTFS_DEV} /bootfs
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

  ######
  # check for a full-fledged sdcard image in update dir
  echo -ne "[5/5] Checking for sdcard image... "

  # if we flashed either rootfs or bootfs we are finished
  if [[ ${FLASHED_ROOTFS} -eq 1 ]] || [[ ${FLASHED_BOOTFS} -eq 1 ]]; then
    echo "skipped, OK<br/>"
    return 0
  fi

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

      # find out if the hardware platform of the current rootfs and the one
      # we are going to flash are the same
      BOOTFS_PLATFORM=$(cat /VERSION | grep PLATFORM= | cut -d= -f2)
      if [[ -z "${BOOTFS_PLATFORM}" ]]; then
        echo "ERROR: (BOOTFS_PLATFORM)<br/>"
        exit 1
      fi

      # mount fs readonly
      mount -o ro,loop ${BOOTFS_LOOPDEV} /mnt
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (lo mount)<br/>"
        exit 1
      fi

      # get platform info in image file
      IMG_PLATFORM=$(cat /mnt/VERSION | grep PLATFORM= | cut -d= -f2)

      # unmount immediately
      umount -f /mnt
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (umount /mnt)<br/>"
        exit 1
      fi

      # check if plaform is non-empty
      if [[ -z "${IMG_PLATFORM}" ]]; then
        echo "ERROR: (IMG_PLATFORM)<br/>"
        exit 1
      fi

      # check if both PLATFORM match
      if [[ "${BOOTFS_PLATFORM}" != "${IMG_PLATFORM}" ]]; then
        echo "ERROR: incorrect hardware platform (${IMG_PLATFORM} != ${BOOTFS_PLATFORM})<br/>"
        exit 1
      fi

      # unmount /bootfs and flash the image using dd
      echo -ne "flashing bootfs.."
      umount -f ${BOOTFS_DEV}

      # start a progress bar outputing dots every few seconds
      while :;do echo -n .;sleep 3;done &
      PROGRESS_PID=$!
      trap "kill ${PROGRESS_PID}; rm -f /tmp/.runningFirmwareUpdate" EXIT

      # use dd to write the image file to the boot partition
      /bin/dd if=${BOOTFS_LOOPDEV} of=${BOOTFS_DEV} bs=4M conv=fsync status=none
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (dd)<br/>"
        exit 1
      fi

      # stop the progress output
      kill ${PROGRESS_PID} && trap "rm -f /tmp/.runningFirmwareUpdate" EXIT

      mount -o ro ${BOOTFS_DEV} /bootfs
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (mount)<br/>"
        exit 1
      fi

      echo -ne "OK, "

      # on the tinkerboard platform we have to check if we can
      # update U-Boot as well.
      if [[ "${BOOTFS_PLATFORM}" == "tinkerboard" ]]; then
        BOOTFS_ROOTDEV=$(/sbin/blkid | grep -v "${LOFS_DEV}" | grep PTTYPE | cut -f1 -d:)
        BOOTFS_START=$(/sbin/fdisk -l ${BOOTFS_ROOTDEV} | grep FAT32 | head -1 | awk '{ printf $3 }')
        BOOTFS_LOOPROOTDEV=$(/sbin/blkid | egrep "${LOFS_DEV}.*PTTYPE" | cut -f1 -d:)
        BOOTFS_LOOPSTART=$(/sbin/fdisk -l ${BOOTFS_LOOPROOTDEV} | grep FAT32 | head -1 | awk '{ printf $3 }')
        echo -ne "updating U-Boot..."
        if [[ "${BOOTFS_START}" == "${BOOTFS_LOOPSTART}" ]] && [[ "${BOOTFS_LOOPSTART}" == "2048" ]]; then
          /bin/dd if=${BOOTFS_LOOPROOTDEV} of=${BOOTFS_ROOTDEV} bs=32K count=31 seek=1 skip=1 conv=fsync status=none
          if [[ $? -ne 0 ]]; then
            echo "ERROR: (dd)<br/>"
            exit 1
          fi
          echo -ne "OK, "
        else
          echo -ne "WARNING (${BOOTFS_START}:${BOOTFS_LOOPSTART}), "
        fi
      fi
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

      # find out if the hardware platform of the current rootfs and the one
      # we are going to flash are the same
      ROOTFS_PLATFORM=$(cat /VERSION | grep PLATFORM= | cut -d= -f2)
      if [[ -z "${ROOTFS_PLATFORM}" ]]; then
        echo "ERROR: (ROOTFS_PLATFORM)<br/>"
        exit 1
      fi

      # mount fs readonly
      mount -o ro,loop ${ROOTFS_LOOPDEV} /mnt
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (lo mount)<br/>"
        exit 1
      fi

      # get platform info in image file
      IMG_PLATFORM=$(cat /mnt/VERSION | grep PLATFORM= | cut -d= -f2)

      # unmount immediately
      umount -f /mnt
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (umount /mnt)<br/>"
        exit 1
      fi

      # check if plaform is non-empty
      if [[ -z "${IMG_PLATFORM}" ]]; then
        echo "ERROR: (IMG_PLATFORM)<br/>"
        exit 1
      fi

      # check if both PLATFORM match
      if [[ "${ROOTFS_PLATFORM}" != "${IMG_PLATFORM}" ]]; then
        echo "ERROR: incorrect hardware platform (${IMG_PLATFORM} != ${ROOTFS_PLATFORM})<br/>"
        exit 1
      fi

      # unmount /rootfs and flash the image using dd
      echo -ne "flashing rootfs.."
      umount -f ${ROOTFS_DEV}

      # start a progress bar outputing dots every few seconds
      while :;do echo -n .;sleep 3;done &
      PROGRESS_PID=$!
      trap "kill ${PROGRESS_PID}; rm -f /tmp/.runningFirmwareUpdate" EXIT

      # use dd to write the image file to the boot partition
      /bin/dd if=${ROOTFS_LOOPDEV} of=${ROOTFS_DEV} bs=4M conv=fsync status=none
      if [[ $? -ne 0 ]]; then
        echo "ERROR: (dd)<br/>"
        exit 1
      fi

      # stop the progress output
      kill ${PROGRESS_PID} && trap "rm -f /tmp/.runningFirmwareUpdate" EXIT

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
    return 0
  fi

  echo "<br/>"
  echo "WARNING: no firmware update/recovery performed<br/>"
  exit 1
}

#################################
# main body starts here

# there can be only one!
if [[ -f /tmp/.runningFirmwareUpdate ]]; then
  echo "ERROR: Firmware Update already running<br/>"
  exit 1
fi

# capture on EXIT and create the lock file
trap 'rm -f /tmp/.runningFirmwareUpdate' EXIT
touch /tmp/.runningFirmwareUpdate

# source all data from /var/hm_mode
[[ -r /var/hm_mode ]] && . /var/hm_mode

# fast blink magenta on RPI-RF-MOD
if [[ "${HM_RTC}" == "rx8130" ]]; then
  echo none  >/sys/class/leds/rpi_rf_mod\:green/trigger
  echo timer >/sys/class/leds/rpi_rf_mod\:red/trigger
  echo timer >/sys/class/leds/rpi_rf_mod\:blue/trigger
  echo 100 >/sys/class/leds/rpi_rf_mod\:red/delay_on
  echo 100 >/sys/class/leds/rpi_rf_mod\:red/delay_off
  echo 100 >/sys/class/leds/rpi_rf_mod\:blue/delay_on
  echo 100 >/sys/class/leds/rpi_rf_mod\:blue/delay_off
fi

# if an argument was given (filename of the update file/data)
# we run fwprepare to verify its validity
if [[ "$#" -eq 1 ]]; then
  fwprepare ${1}
fi

# run the fwinstall function to actually
# run the unattended firmware update
echo "Starting firmware update (DO NOT INTERRUPT!!!):<br/>"
fwinstall
echo "Finished firmware update successfully.<br/>"

exit 0
