#!/bin/sh
#
# Helper script to unarchive an neoserver update
# archive and update the local buildroot package

ARCHIVE="${1}"
TMPDIR=$(mktemp -d)

tar -C "${TMPDIR}" -xf "${ARCHIVE}"
echo "${TMPDIR}"

cp -a "${TMPDIR}/VERSION" pkg/mediola/
chmod 644 pkg/mediola/VERSION
#cp -a ${TMPDIR}/data/README.md pkg/mediola/
#chmod 644 pkg/mediola/README.md
#rm -rf pkg/mediola/bin
cp -a "${TMPDIR}/bin" pkg/mediola/
cp -a "${TMPDIR}/mediola_addon.cfg" pkg/mediola/
chmod 644 pkg/mediola/mediola_addon.cfg
rm -rf pkg/mediola/rc.d
cp -a "${TMPDIR}/rc.d" pkg/mediola/
rm -rf pkg/mediola/neo_server
cp -a "${TMPDIR}/neo_server" pkg/mediola/
#find pkg/mediola/neo_server -xdev -type d -exec chmod -R 744 {} \;
#find pkg/mediola/neo_server -xdev -type f -exec chmod -R 644 {} \;

rm -rf overlay/opt/mediola/www
cp -a "${TMPDIR}/www" overlay/opt/mediola/
#find overlay/opt/mediola/www -xdev -type d -exec chmod -R 744 {} \;
#find overlay/opt/mediola/www -xdev -type f -exec chmod -R 644 {} \;

rm -rf "${TMPDIR}"
