#!/bin/tclsh

set DPControls_GETSTATUS(GENERIC) [list GenericControl_getStatus]

proc GenericControl_getStatus { channelId dataPoint } {
	set name [GenericControl_getDPName $channelId $dataPoint]
	set value [GenericControl_getDPValue $channelId $dataPoint]
	
	set    result [status_separator]
	append result {<tr><td class="status">}
	append result "<div class=\"caption\">$name</div>"
	append result "<div class=\"center\">$value</div>"
	append result {</td></tr>}
	
	return $result
}

proc GenericControl_getDPName { channelId dataPoint } {
	array set dp $dataPoint
	
	set    script "var channelId = \"$channelId\";"
	append script "var dpId = \"$dp(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dp = dom.GetObject(dpId);
		var shortKey = dp.HSSID();
		var longKey = channel.ChnLabel() # "|" # shortKey;
		var value = web.webKeyFromStringTable(longKey);
		if ( !value.Length() ) { value = web.webKeyFromStringTable(shortKey); }
		Write(value);
	}
	
	set name [rega_exec $script]
	#if { "" == $name } { set name $dp(ID) }
	
	return $name
}

proc GenericControl_getDPValue { channelId dataPoint } {
	array set dp $dataPoint
	
	set    script "var channelId = \"$channelId\";"
	append script "var dpId= \"$dp(ID)\";"
	append script {
		var channel = dom.GetObject(channelId);
		var dp = dom.GetObject(dpId);
		if (!dp.IsTypeOf(OT_HSSDP)) { quit; }
		
		var value = dp.Value();
		var type = value.Type();
		var valueType = dp.ValueType();
		var subType = dp.ValueSubType();
		
		! Ersetzungen aus StringTable
		var shortKey = dp.HSSID();
		var longKey  = channel.ChnLabel() # "|" # shortKey;
		
		! Werteliste
		if ((valueType == ivtInteger) && (subType == istEnum))
		{
			var temp = web.webGetValueFromList(dp.ValueList(), value);
			shortKey = shortKey # "=" # temp;
			longKey  = longKey  # "=" # temp;
			var temp2 = web.webKeyFromStringTable(longKey);
			if ( "" == temp2) { temp2 = web.webKeyFromStringTable(shortKey); }
			if ( "" != temp2) { value = temp2; }
		}
		
		! boolesche Typen
		if ((valueType == ivtBinary) && ((subType == istGeneric) || (subType == istBool) || (subType == istSwitch)))
		{
			if (value) { longKey = longKey # "=TRUE"; shortKey = shortKey # "=TRUE"; }
			else  { longKey = longKey # "=FALSE"; shortKey = shortKey # "=FALSE"; }
			var temp = web.webKeyFromStringTable(longKey);
			if ( "" == temp) { temp = web.webKeyFromStringTable(shortKey); }
			if ( "" != temp) { value = temp; }
		}
		
		if ("boolean" == type)
		{
			if (value == true) { longKey = longKey # "=TRUE"; shortKey = shortKey # "=TRUE"; }
			else  { longKey = longKey # "=FALSE"; shortKey = shortKey # "=FALSE"; }
			var temp = web.webKeyFromStringTable(longKey);
			if ( "" == temp) { temp = web.webKeyFromStringTable(shortKey); }
			if ( "" != temp) { value = temp; }
		}
		
		! Einheit
		var unit = dp.ValueUnit();
		if (unit == "degree") { unit = "&deg;"; }
		if (unit == "100%" )
		{
			value = value * 100.0;
			value = value.ToString(0);
			unit  = "%";
		}
		
		! Realzahl
		if ("real" == type) { value = value.ToString(2); }
		
		! Ganzzahl
		if (("real" != type) && ("boolean" != type)) { value = value.ToString(0); }
		
		if ( "" == value.ToString()) { value = "0"; }
		
		
		! Ausgabe
		Write(value # " " # unit);
	}
	
#	puts "<pre>$script</pre>"
	set value [rega_exec $script]
	if {"" == $value } { set value "Unbekannt" }
	
	return $value
}