#!/bin/sh

echo -ne "Content-Type: text/plain\r\n\r\n"
echo -ne "Receiving Uploaded File.. "

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

# extract all params from QUERY_STRING
eval $(echo ${QUERY_STRING//&/;})

# write out the data
SIZE=$((HTTP_CONTENT_LENGTH-a))
filename=$(mktemp -p /usr/local/tmp)
head -c $SIZE >${filename}

echo -ne "$(stat -c%s ${filename}) bytes received.\r\n"

echo -ne "Calculating SHA256 checksum: "
CHKSUM=$(/usr/bin/sha256sum ${filename})
if [ $? -ne 0 ]; then
  echo -ne "ERROR (sha256sum)\r\n"
  exit 1
fi
echo -ne "$(echo ${CHKSUM} | awk '{ print $1 }')\r\n"
