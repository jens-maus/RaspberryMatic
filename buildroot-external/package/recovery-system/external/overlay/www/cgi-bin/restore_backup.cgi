#!/bin/sh

echo -ne "Content-Type: text/html; charset=iso-8859-1\r\n\r\n"

echo -ne "[1/7] Checking /userfs... "

mount | grep -q /userfs
if [ $? -ne 0 ]; then
  echo "ERROR: userfs not available"
  exit 1
fi
echo "done.<br>"

mount -o rw,remount /userfs
if [ $? -ne 0 ]; then
  echo "ERROR (rw remount)"
  exit 1
fi

echo -ne "[2/7] Processing uploaded data... "

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

echo -ne "[3/7] Calculating SHA256 checksum: "
CHKSUM=$(/usr/bin/sha256sum ${filename})
if [ $? -ne 0 ]; then
  echo "ERROR (sha256sum)"
  exit 1
fi
echo "$(echo ${CHKSUM} | awk '{ print $1 }')<br>"

echo -ne "[3/7] Extracting to temp location... "

TMPDIR=${filename}-dir
mkdir -p ${TMPDIR}

/bin/tar -C ${TMPDIR} -xf ${filename} 2>/dev/null
if [ $? -ne 0 ]; then
  echo "ERROR (untar)"
  exit 1
fi

echo "OK<br>"

# check the firmware version
echo -ne "[4/7] Checking backup version... "
source ${TMPDIR}/firmware_version
BACKUP_VERSION=${VERSION}
if [ $(echo ${BACKUP_VERSION} | cut -d'.' -f1) != "2" ]; then
  echo "ERROR: backup version (${BACKUP_VERSION}) not supported"
  exit 1
fi
echo "${BACKUP_VERSION}, OK<br>"

# verify security key settings
echo -ne "[5/7] Verifying security key settings... "
SYSTEM_HAS_USER_KEY=$(/bin/crypttool -v -t 0)
STORED_SIGNATURE=$(cat ${TMPDIR}/signature)
STORED_KEYINDEX=$(cat ${TMPDIR}/key_index)
CALCED_SIGNATURE=$(/bin/crypttool -s -t 0 <${TMPDIR}/usr_local.tar.gz)

# check for syskey
if [ -n "${SYSTEM_HAS_USER_KEY}" ]; then
  echo -ne "NO syskey, "
else
  echo -ne "syskey, "
fi

# check for userkey
if [ "${STORED_SIGNATURE}" != "${CALCED_SIGNATURE}" ]; then
  echo -ne "userkey, "
else
  echo -ne "NO userkey"
fi
echo "<br>"

# put usr_local.tar.gz to tmp dir
echo -ne "[6/7] Prepare backup restore... "
mv -f ${TMPDIR}/usr_local.tar.gz /usr/local/tmp/
if [ $? -ne 0 ]; then
  echo "ERROR (mv)"
  exit 1
fi

touch /usr/local/.doBackupRestore
if [ $? -ne 0 ]; then
  echo "ERROR (touch)"
  exit 1
fi

mount -o ro,remount /userfs
if [ $? -ne 0 ]; then
  echo "ERROR (ro umount)"
  exit 1
fi


echo "OK<br>"

echo "[7/7] Rebooting..."
/sbin/reboot
