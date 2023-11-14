#!/bin/tclsh
#
# positive result:
#
# 1)
# result(STDOUT)        = 
# result(httpUserAgent) = 
# result(name)          = HM-RCV-50 BidCoS-RFö
# result(obj)           = HM-RCV-50 BidCoS-RFö
# result(sessionId)     = 
# result(uname)         = HM%2DRCV%2D50%20BidCoS%2DRF%F6
# => MUST contain %F6 (ISO)
#
# 2)
# result(STDOUT)        = 
# result(httpUserAgent) = 
# result(name)          = HM%2DRCV%2D50%20BidCoS%2DRF%F6
# result(obj)           = HM-RCV-50 BidCoS-RFö
# result(sessionId)     = 
# result(uname)         = HM%2DRCV%2D50%20BidCoS%2DRF%F6
# => MUST contain %F6 (ISO)
#
# 3)
# result(STDOUT)        = 
# result(httpUserAgent) = 
# result(name)          = HM-RCV-50 BidCoS-RFö
# result(obj)           = HM-RCV-50 BidCoS-RFö
# result(sessionId)     = 
# result(uname)         = HM%2DRCV%2D50%20BidCoS%2DRF%F6
# => MUST contain %F6 (ISO)
# 
# Summary:
# piped to "hexdump -C" all umlauts have to be ISO encoded


load tclrega.so

set name "HM-RCV-50 BidCoS-RF�"
set uid 1645

# get current
set    cmd ""                                                                                            
append cmd "object obj = dom.GetObject($uid);"
append cmd "string uname = obj.Name().UriEncode();"
append cmd "string name = obj.Name();"
array set result [rega_script "$cmd"] 
parray result

puts ""

# set ISO
set    cmd ""                                                                                            
append cmd "object obj = dom.GetObject($uid);"
append cmd "obj.Name('$name');"
append cmd "string name = obj.Name().UriEncode();"
array set result [rega_script "$cmd"] 
parray result

puts ""

# get ISO
set    cmd ""                                                                                            
append cmd "object obj = dom.GetObject($uid);"
append cmd "string uname = obj.Name().UriEncode();"
append cmd "string name = obj.Name();"
array set result [rega_script "$cmd"] 
parray result
