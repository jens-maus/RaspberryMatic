#!/bin/sh
#
# positive result:
#
# 1)
# 00000060  41 67 65 6e 74 3e 3c 76  61 6c 75 65 3e 48 4d 2d  |Agent><value>HM-|
# 00000070  52 43 56 2d 35 30 20 42  69 64 43 6f 53 2d 52 46  |RCV-50 BidCoS-RF|
# 00000080  f6 3c 2f 76 61 6c 75 65  3e 3c 2f 78 6d 6c 3e     |.</value></xml>|
# => MUST contain f6 (ISO code)
#
# 2)
# 00000050  37 2e 37 39 2e 31 3c 2f  68 74 74 70 55 73 65 72  |7.79.1</httpUser|
# 00000060  41 67 65 6e 74 3e 3c 76  61 6c 75 65 3e 74 72 75  |Agent><value>tru|
# 00000070  65 3c 2f 76 61 6c 75 65  3e 3c 2f 78 6d 6c 3e     |e</value></xml>|
# => MUST contain "true"
#
# 3)
# 00000060  41 67 65 6e 74 3e 3c 76  61 6c 75 65 3e 48 4d 2d  |Agent><value>HM-|
# 00000070  52 43 56 2d 35 30 2b 42  69 64 43 6f 53 2d 52 46  |RCV-50+BidCoS-RF|
# 00000080  f6 3c 2f 76 61 6c 75 65  3e 3c 2f 78 6d 6c 3e     |.</value></xml>|
# => MUST contain f6 (ISO code)
#

# get current
curl -v -k -s -G --data-urlencode "value=dom.GetObject(1645).Name()" http://localhost:8183/hm.exe | hexdump -C

echo

# set ISO
NAME="HM-RCV-50 BidCoS-RFö"
curl -v -k -s -G --data-urlencode "value=dom.GetObject(1645).Name('${NAME}')" http://localhost:8183/hm.exe | hexdump -C

echo 

# get ISO
curl -v -k -s -G --data-urlencode "value=dom.GetObject(1645).Name()" http://localhost:8183/hm.exe | hexdump -C
