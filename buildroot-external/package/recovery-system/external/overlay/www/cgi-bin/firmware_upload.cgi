#!/bin/sh

echo -ne "Content-Type: text/html; charset=iso-8859-1\r\n\r\n"

echo -ne "[1/2] Processing uploaded data... "

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

echo -ne "[2/2] Calculating SHA256 checksum: "
CHKSUM=$(/usr/bin/sha256sum ${filename})
if [ $? -ne 0 ]; then
  echo "ERROR (sha256sum)"
  exit 1
fi
echo "$(echo ${CHKSUM} | awk '{ print $1 }')<br>"
