#!/bin/sh

echo -ne "Content-Type: text/html; charset=iso-8859-1\r\n\r\n"

# cleanup first
rm -f /usr/local/.firmwareUpdate

# process data upload
echo -ne "[1/5] Processing uploaded data... "

# fake read boundary+disposition, etc.
read boundary
read disposition
read ctype
read junk

# get length
a=${#boundary}
b=${#disposition}
c=${#ctype}

# Due to \n\r line breaks we have 2 extra bytes per line read,
# 6 + 2 newlines == 10 junk bytes
a=$((a*2+b+c+d+10))

# write out the data
SIZE=$((HTTP_CONTENT_LENGTH-a))
filename=$(mktemp -p /usr/local/tmp)
head -c $SIZE >${filename}
if [ $? -ne 0 ]; then
  echo "ERROR (head)"
  exit 1
fi

echo "$(stat -c%s ${filename}) bytes received.<br>"

echo -ne "[2/5] Calculating SHA256 checksum: "
CHKSUM=$(/usr/bin/sha256sum ${filename})
if [ $? -ne 0 ]; then
  echo "ERROR (sha256sum)"
  exit 1
fi
echo "$(echo ${CHKSUM} | awk '{ print $1 }')<br>"

########
# check if file is a valid firmware update/recovery file
echo -ne "[3/5] Checking/Unarchiving data... "

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
    /bin/tar -C ${TMPDIR} --no-same-owner -xf ${filename}
    if [ $? -ne 0 ]; then
      echo "ERROR: (untar)"
      exit 1
    fi

    rm -f ${filename}

    FILETYPE="tar"
  fi
fi

# check for .zip
if [ -z "${FILETYPE}" ]; then
  /usr/bin/file -b ${filename} | grep -q "Zip archive data"
  if [ $? -eq 0 ]; then
    /usr/bin/unzip -q -o -d ${TMPDIR} ${filename} 2>/dev/null
    if [ $? -ne 0 ]; then
      echo "ERROR: (unzip)"
      exit 1
    fi

    rm -f ${filename}

    FILETYPE="zip"
  fi
fi

# check for .img
if [ -z "${FILETYPE}" ]; then
  /usr/bin/file -b ${filename} | egrep -q "DOS/MBR boot sector.*partition 3"
  if [ $? -eq 0 ]; then
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
    # the file seems to be a vfat fs of the bootfs lets check if the ext4 is valid
    /sbin/fsck.fat -nf ${filename} 2>/dev/null >/dev/null
    if [ $? -ne 0 ]; then
      echo "ERROR: (fsck.fat)"
      exit 1
    fi

    mv -f ${filename} ${TMPDIR}/bootfs.vfat

    FILETYPE="vfat"
  fi
fi

if [ -z "${FILETYPE}" ]; then
  echo "ERROR: no valid filetype found"
  exit 1
else
  echo "'${FILETYPE}' data type identified, OK<br/>"
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
      echo "OK (sha256sum), "
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
      echo "OK (md5sum), "
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

echo "DONE<br>"

echo "<br/>"

######
# lets start the firmware update now using /bin/fwinstall.sh
# and if it returns 0 everything was fine and we can reboot!
/bin/fwinstall.sh
if [ $? -ne 0 ]; then
  echo "ERROR: (fwinstall)"
  exit 1
fi

echo "Rebooting..."
/sbin/reboot
