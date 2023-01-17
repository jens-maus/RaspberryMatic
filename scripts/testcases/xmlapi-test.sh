#!/bin/sh
#
# positive result:
#
# 1)
# 00000040  73 65 72 2d 41 67 65 6e  74 3a 20 63 75 72 6c 2f  |ser-Agent: curl/|
# 00000050  37 2e 37 39 2e 31 3c 2f  68 74 74 70 55 73 65 72  |7.79.1</httpUser|
# 00000060  41 67 65 6e 74 3e 3c 76  61 6c 75 65 3e 74 72 75  |Agent><value>tru|
# 00000070  65 3c 2f 76 61 6c 75 65  3e 3c 2f 78 6d 6c 3e     |e</value></xml>|
# => MUST contain "true"
#
# 2)
# 00001830  3c 2f 64 65 76 69 63 65  3e 3c 64 65 76 69 63 65  |</device><device|
# 00001840  20 6e 61 6d 65 3d 27 48  6d 49 50 2d 52 43 56 2d  | name='HmIP-RCV-|
# 00001850  35 30 20 48 6d 49 50 2d  52 43 56 2d 31 f6 27 20  |50 HmIP-RCV-1.' |
# 00001860  61 64 64 72 65 73 73 3d  27 48 6d 49 50 2d 52 43  |address='HmIP-RC|
# 00001870  56 2d 31 27 20 69 73 65  5f 69 64 3d 27 31 38 35  |V-1' ise_id='185|
# 00001880  33 27 20 69 6e 74 65 72  66 61 63 65 3d 27 48 6d  |3' interface='Hm|
# => MUST contain f6 (ISO encoded name)
#

ISEID=1853
NAME="HmIP-RCV-50%20HmIP-RCV-1%F6"

# set ISO name
curl -vvvv http://localhost:8183/hm.exe?value=dom.GetObject%28${ISEID}%29.Name%28%27${NAME}%27%29 | hexdump -C

echo

# get xmlapi device list
curl -vvvv http://localhost/addons/xmlapi/devicelist.cgi | hexdump -C
