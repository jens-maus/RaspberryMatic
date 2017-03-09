#!/bin/sh

destdir=/media

eumount()
{
  if grep -qs "^/dev/$1 " /proc/mounts ; then
    umount "${destdir}/$1";
  fi

  [ -d "${destdir}/$1" ] && rmdir "${destdir}/$1"
}

emount()
{
  mkdir -p "${destdir}/$1" || exit 1

  if ! mount -t auto "/dev/$1" "${destdir}/$1"; then
    # failed to mount, clean up mountpoint
    rmdir "${destdir}/$1"
    exit 1
  fi
}

case "${ACTION}" in
  add|"")
    eumount ${MDEV}
    emount ${MDEV}
  ;;

  remove)
    eumount ${MDEV}
  ;;
esac
