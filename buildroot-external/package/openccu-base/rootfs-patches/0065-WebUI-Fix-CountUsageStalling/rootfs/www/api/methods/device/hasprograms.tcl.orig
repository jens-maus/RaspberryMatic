##
# Device.hasPrograms
# Prüft, ob für ein Gerät Programme bestehen
#
# Parameter:
#   id: [string] Id des Geräts
#
# Rückgabewert: [boolean]
#  true, falls Programme für das Gerät bestehen.
##

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

# When this device is involved in any programs then devHasPrograms should be true
set devHasPrograms [hmscript $hasPrograms args]

if {$devHasPrograms == "true"} then {
  jsonrpc_response true 
} else {
  jsonrpc_response false
}

