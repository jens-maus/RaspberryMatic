##
# Device.hasLinksOrPrograms
# Prüft, ob für ein Gerät Programme oder externe direkte Geräteverknüpfungen bestehen
#
# Parameter:
#   id: [string] Id des Geräts
#
# Rückgabewert: [boolean]
#  true, falls Programme oder externe direkte Verknüpfungen für das Gerät bestehen.
##


proc getIfaceURL {interface} {
  global INTERFACE_LIST
  switch $interface {
   "BidCos-RF" {array set ifaceList $INTERFACE_LIST(BidCos-RF)}      
   "BidCos-Wired" {array set ifaceList $INTERFACE_LIST(BidCos-Wired)}      
   "HmIP-RF" {array set ifaceList $INTERFACE_LIST(HmIP-RF)}
   "HmIP-Wired" {array set ifaceList $INTERFACE_LIST(HmIP-Wired)}
  }
  return $ifaceList(URL)
}

set getInterface {
  var device = dom.GetObject(id);
  Write(dom.GetObject(device.Interface()));
}

set getParentAddress {
  var device = dom.GetObject(id);
  if (device) {
    Write(device.Address());
  }
}

set getChannels {
  var device = dom.GetObject(id);
  var channel;
  var address = "";

  var parentAddress = device.Address();

  if (device)
  {
    string channelId;
    foreach(channelId, device.Channels())
    {
      channel = dom.GetObject(channelId);
      address = channel.Address()#" ";
      Write(address);
    }
  }
}

set hasPrograms {
  var device             = dom.GetObject(id);
  var hasPrograms = "false";
  
  if (device)
  {
    string channelId;
    foreach(channelId, device.Channels())
    {
      var channel = dom.GetObject(channelId);
      if (channel.ChnDPUsageCount() > 0) { hasPrograms = "true"; }
    }
  }
  Write(hasPrograms);
}

set hasLinks {
  var device             = dom.GetObject(id);
  var hasLinks = "false";
  
  if (device)
  {
    string channelId;
    foreach(channelId, device.Channels())
    {
      var channel = dom.GetObject(channelId);
      if (channel.ChnLinkCount()    > 0) { hasLinks = "true"; } 
    }
  }
  Write(hasLinks);
}

# When this device is involved in any programs then hasLinksOrPrograms should be true
set hasLinksOrPrograms [hmscript $hasPrograms args]

# If there are no programs, check whether the device has external links
if {$hasLinksOrPrograms == "false"} {
  # If there are links available check whether that are external links      
  # Internal links are links within the device with its keys. They don´t matter.
  if {[hmscript $hasLinks args] == "true"} {
    set url [getIfaceURL [hmscript $getInterface args]] 
    set parentAddress [hmscript $getParentAddress args]
    set channels [hmscript $getChannels args]

    # Examine for each channel its link peers
    foreach channel $channels {
      #channel = "abc1234567:0 - abc1234567:n"
      set channelNr [lindex [split $channel ":"] 1]
  
      # all channels > 0 
      if {$channelNr > 0} {
        # get all links of this channel      
        set arrLinks [xmlrpc $url getLinks [ list string $channel] ] 
        
        # Go through each link 
        foreach link $arrLinks {
          array set devDescr [xmlrpc $url getDeviceDescription [list string $channel]]
          array set linkDescr $link
          set direction $devDescr(DIRECTION)
          
          # When I am a sender then my peer is a receiver and vice versa 
          if {$direction == "1"} {
            set peer $linkDescr(RECEIVER)
          } elseif {$direction == "2"} {
            set peer $linkDescr(SENDER)
          } else {
            # Leave this loop. The delete dialog will give no hint if a link is available
            # We should never reach this point.
            break;
          }
          # If the parent address of the link peer isn´t the same as the device parent address then it´s an external link.
          set peerParentAddress [lindex [split $peer ":"]  0]
          
          if {($parentAddress != $peerParentAddress) && ([string index $peerParentAddress 0] != "@") } {
            set hasLinksOrPrograms "true";
            # We don´t need further examination.
            break;
          }   
        }
      }
    }
  }
}
# Consider only external links and take no notice of internal links.
# Internal links are e.g. links between a device key and the device itself.

if {$hasLinksOrPrograms == "true"} then {
  jsonrpc_response true 
} else {
  jsonrpc_response false
}

