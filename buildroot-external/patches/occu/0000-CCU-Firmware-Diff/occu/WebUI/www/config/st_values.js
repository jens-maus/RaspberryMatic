/*
Übersetzt den Inhalt der HTML-Elemente <span class="stringtable_value">...</span>
und <select class="stringtable_select">...</select>
*/
st_setStringTableValues = function()
{
	var translation;
	
	//In <span class="stringtable_value">...</span> eingeschlossene Wörter übersetzen
	var temp = document.getElementsByClassName('stringtable_value');
  
    var wrappers = new Array();
	for (var i=0; i<temp.length; i++)
	{	
		wrappers[i]=temp[i];
	}
    
	for (var i=0; i<wrappers.length; i++)
	{	
		wrappers[i].innerHTML = st_getValue( wrappers[i].innerHTML ).escapeHTML();
		wrappers[i].className += "_translated";
	}
	//-------------------------------------------------------------------------

	//Comboboxen übersetzen <select class="stringtable_select" ... >...</select>
	var temp = document.getElementsByClassName('stringtable_select');

	var selboxes = new Array();
	for (var i = 0, len = temp.length; i < len; i++)
	{
		selboxes[i] = temp[i];
	}
	
	for (var i=0; i<selboxes.length; i++)
	{
		var selectelem = selboxes[i];

		if (selectelem.type != "select-one") continue;
		
		for (var k=0; k<selectelem.options.length; k++)
		{
			selectelem.options[k].text = st_getValue(selectelem.options[k].text).escapeHTML();
		}

		selectelem.className += "_translated";
	}
	//-------------------------------------------------------------------------
	
	//Input-Felder übersetzen <input class="stringtable_input" ...> 
	var temp = document.getElementsByClassName('stringtable_input');

	var input = new Array();
	for (var i = 0, len = temp.length; i < len; i++)
	{
		input[i] = temp[i];
	}

	for (var i = 0; i < input.length; i ++)
	{
		input[i].value = st_getValue(input[i].value).escapeHTML();
		input[i].className += "_translated";
	}

};

//Eingabeparameter
//context: <channeltype>|<value_id>(=<value>)?
//context: <channeltype>|<value_id>
//context: <value_id>
//Rückgabeparameter:
//return: übersetzung, wenn context gefunden in den Spezialisierungsgraden:
//	1. <channeltype>|<value_id>(=<value>)?
//	2. <channeltype>|<value_id>
//	3. <value_id>
//	sonst: value, wenn value aus dem context extrahiert werden kann
//	sonst: context wird wieder zurückgegeben.
st_getValue = function(context)
{
	var translation;
	var tokens;
	var channel_type;
	var value_id_assign; //Inhalt: <value_id>=<value>
	var value_id;
	var value;
		
	//Voller context vorhanden?=========================================
	translation = elvST[context];

	if (translation && translation != "") return translation;
	//==================================================================
	
	//Gibt es einen Eintrag nur mit value_id_assign?====================
	tokens = context.split('|');
	value_id_assign = "";
	
	if (tokens.length > 1)
	{
		//channel_type = tokens[0];
		value_id_assign = tokens[1];
		translation = elvST[ value_id_assign ];
		if (translation && translation != "") return translation;
	}
	//==================================================================

	//Gibt es einen Eintrag nur mit dem Variablennamen?=================
	tokens = context.split('=');
	value = "";
	
	if (tokens.length > 1)
	{
		//value_id = tokens[0];
		value = tokens[1];
		translation = elvST[ value ];
		if      (translation && translation != "") return translation;
		else if (value       && value       != "") return value;
	}
	//==================================================================
	
	//Gibt es einen Eintrag im INPUT-Feld?==============================

	tokens = context.split(" ");
	translation = "";

	for (var i = 0; i < tokens.length; i++)
	{
		if (typeof elvST[tokens[i]] != 'undefined') 
		{
			tokens[i] = elvST[tokens[i]];
		}
		translation += tokens[i] + " ";
	}
	if (translation && translation != "") return translation;
	//==================================================================

	if (value_id_assign && value_id_assign != "") return value_id_assign;
	else                                          return context;
};
//<.
