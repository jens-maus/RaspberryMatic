#!/bin/sh
#
# positive result:
#
# 1)
# 00000020  22 3a 22 31 36 34 35 22  2c 22 6e 61 6d 65 22 3a  |":"1645","name":|
# 00000030  22 48 4d 2d 52 43 56 2d  35 30 20 42 69 64 43 6f  |"HM-RCV-50 BidCo|
# 00000040  53 2d 52 46 c3 b6 22 2c  22 61 64 64 72 65 73 73  |S-RF..","address|
# => MUST contain c3b6 (UTF-8 code)
#
# 2)
# 00000010  22 2c 22 72 65 73 75 6c  74 22 3a 20 22 48 4d 2d  |","result": "HM-|
# 00000020  52 43 56 2d 35 30 20 42  69 64 43 6f 53 2d 52 46  |RCV-50 BidCoS-RF|
# 00000030  c3 b6 22 2c 22 65 72 72  6f 72 22 3a 20 6e 75 6c  |..","error": nul|
# => MUST contain c3b6 (UTF-8 code)
#
# 3)
# 00000010  22 2c 22 72 65 73 75 6c  74 22 3a 20 7b 22 69 64  |","result": {"id|
# 00000020  22 3a 22 31 36 34 35 22  2c 22 6e 61 6d 65 22 3a  |":"1645","name":|
# 00000030  22 48 4d 2d 52 43 56 2d  35 30 20 42 69 64 43 6f  |"HM-RCV-50 BidCo|
# 00000040  53 2d 52 46 c3 b6 22 2c  22 61 64 64 72 65 73 73  |S-RF..","address|
# => MUST contain c3b6 (UTF-8 code)
#
# 4)
# 00000060  41 67 65 6e 74 3e 3c 76  61 6c 75 65 3e 48 4d 2d  |Agent><value>HM-|
# 00000070  52 43 56 2d 35 30 20 42  69 64 43 6f 53 2d 52 46  |RCV-50 BidCoS-RF|
# 00000080  f6 3c 2f 76 61 6c 75 65  3e 3c 2f 78 6d 6c 3e     |.</value></xml>|
# => MUST contain f6 (ISO code)
#

SID="XIgibdK3v1"
ID=1645
NAME="HM-RCV-50 BidCoS-RFö"

# get current
curl -vvv "http://localhost/api/homematic.cgi" \
     -H 'Content-Type: application/json; charset=iso-8859-1' \
     --data-raw "{\"version\": \"1.1\", \"method\": \"Device.get\", \"params\": {\"id\": \"${ID}\", \"_session_id_\": \"${SID}\"}}" | hexdump -C | head -10

# set ISO
curl -vvv "http://localhost/api/homematic.cgi" \
     -H 'Content-Type: application/json; charset=iso-8859-1' \
     --data-raw "{\"version\": \"1.1\", \"method\": \"Device.setName\", \"params\": {\"id\": \"${ID}\", \"name\": \"${NAME}\", \"_session_id_\": \"${SID}\"}}" | hexdump -C

echo

# get ISO
curl -vvv "http://localhost/api/homematic.cgi" \
     -H 'Content-Type: application/json; charset=iso-8859-1' \
     --data-raw "{\"version\": \"1.1\", \"method\": \"Device.get\", \"params\": {\"id\": \"${ID}\", \"_session_id_\": \"${SID}\"}}" | hexdump -C | head -10

# get ISO via rega to check encoding
curl -v -k -s -G --data-urlencode "value=dom.GetObject(1645).Name()" http://localhost:8183/hm.exe | hexdump -C
