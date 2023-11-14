#!/bin/sh
#
# positive result:
#
# 1)
# 00000060  41 67 65 6e 74 3e 3c 76  61 6c 75 65 3e 48 4d 25  |Agent><value>HM%|
# 00000070  32 44 52 43 56 25 32 44  35 30 25 32 30 42 69 64  |2DRCV%2D50%20Bid|
# 00000080  43 6f 53 25 32 44 52 46  25 46 36 3c 2f 76 61 6c  |CoS%2DRF%F6</val|
# => MUST contain %F6
#
# 2)
# 00000050  37 2e 37 39 2e 31 3c 2f  68 74 74 70 55 73 65 72  |7.79.1</httpUser|
# 00000060  41 67 65 6e 74 3e 3c 76  61 6c 75 65 3e 74 72 75  |Agent><value>tru|
# 00000070  65 3c 2f 76 61 6c 75 65  3e 3c 2f 78 6d 6c 3e     |e</value></xml>|
# => MUST contain true
#
# 3)
# 00000060  41 67 65 6e 74 3e 3c 76  61 6c 75 65 3e 48 4d 2d  |Agent><value>HM-|
# 00000070  52 43 56 2d 35 30 20 42  69 64 43 6f 53 2d 52 46  |RCV-50 BidCoS-RF|
# 00000080  f6 3c 2f 76 61 6c 75 65  3e 3c 2f 78 6d 6c 3e     |.</value></xml>|
# => MUST contain f6
#

# get current
curl -vvv http://localhost:8183/hm.exe?value=dom.GetObject%281645%29.Name%28%29.UriEncode%28%29 | hexdump -C

# set ISO stuff
curl -vvv http://localhost:8183/hm.exe?value=dom.GetObject%281645%29.Name%28%27HM-RCV-50%20BidCoS-RF%F6%27%29 | hexdump -C

# get ISO stuff
curl -vvv http://localhost:8183/hm.exe?value=dom.GetObject%281645%29.Name%28%29 | hexdump -C
