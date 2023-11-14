<html>
<head>


<script type="text/javascript">
  setPath("<span onclick='WebUI.enter(SystemConfigPage);'>"+translateKey('menuSettingsPage')+"</span> &gt; "+ translateKey('submenuCreateDiagram'));
  
 (function () {
	  if (!${initialized?string('true', 'false')}) {
		jQuery("#${TableId} td:nth-child(5)").hide();
		jQuery("#dataloggingError").show();
	  } else {	  
		jQuery("#dataloggingError").hide();
	  }	
	  
	  var s = "";
	  s += "<table cellspacing='8'>";
	  s += "<tr>";
	  s += "<td align='center' valign='middle'><div class='FooterButton' onclick='WebUI.goBack();'>"+ translateKey('footerBtnPageBack') +"</div></td>";
	  <#if objectList?size &lt; 50>
		  if (${initialized?string('true', 'false')}) {
			s += "<td align='center' valign='middle'><div class='FooterButton' onclick='NewDiagram();'>"+ translateKey('footerBtnNew') +"</div></td>";
		  }
		  
		jQuery("#tooManyDiagramsError").hide();
	  </#if>
	  
	  s += "</tr>";
	  s += "</table>";
	  setFooter(s);
	  translateButtons("btnRemove, btnEdit");
	  translatePage("#${TableId}");
	  translatePage("#dataloggingError");
	  translatePage("#tooManyDiagramsError");
	  jQuery("#${TableId}").show();  
	})();
</script>

</head>
<body>
<table id="dataloggingError" class="tTable"  border="0" cellpadding="0" cellspacing="0">
 <tr>
	<td class="CLASS21906">
      ${"$"}{diagramDataloggingNotInitialised}
	</td>
</tr>
</table>
<table id="tooManyDiagramsError" class="tTable"  border="0" cellpadding="0" cellspacing="0">
 <tr>
	<td class="CLASS21906">
      ${"$"}{diagramTooManyDiagrams}
	</td>
</tr>
</table>

<table id="${TableId}" class="tTable"  border="0" cellpadding="0" cellspacing="0">
  <thead>
    <tr>
      <td class="thCell CLASS04900" >${"$"}{thDiagramName}</td>
      <td class="thCell CLASS04900" >${"$"}{thDiagramDescription}</td>
      <td class="thCell CLASS04900" >${"$"}{thDiagramTemplate}</td>
      <td class="thCell CLASS04900" >${"$"}{thDiagramDefaultPeriod}</td>
      <td class="thCell CLASS04900" >${"$"}{thAction}</td>
    </tr>
  </thead>
  <tbody>
  
    <#list objectList as diagram>
    <tr class="CLASS04901">
        <td class="tBodyCell">${diagram.name}</td>
        <td class="tBodyCell">${diagram.description}</td>
        <td class="tBodyCell">
        <#list templates as template>
	        <#if diagram.templateId = template.id>${template.getName()}</#if>
	    </#list>
        </td>
        <td class="tBodyCell">
        		<#if diagram.defaultPeriod = 1>${"$"}{diagramPeriodLastDay}</#if>
	        	<#if diagram.defaultPeriod = 2>${"$"}{diagramPeriodLastWeek}</#if>
	        	<#if diagram.defaultPeriod = 3>${"$"}{diagramPeriodLastMonth}</#if>
	        	<#if diagram.defaultPeriod = 4>${"$"}{diagramPeriodLastYear}</#if>
	    </td>

<!-- Start action column -->        
<td class="tBodyCell CLASS04902" >
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td class="CLASS04903">
<input type="button" name="btnRemove" value="btnRemove" class="StdButton CLASS04907" onclick="DeleteDiagram(${diagram.id});" />
</td>
</tr>
<tr>
<td>
</td>
</tr>
<tr>
<td class="CLASS04903">
<input type="button" name="btnEdit" value="btnEdit" class="StdButton CLASS04907" onclick="EditDiagram(${diagram.id});" />
</td>
</tr>
</table>
</td>
<td>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td class="CLASS04903">
<label class="CLASS04904"><input type="checkbox" ${diagram.active?string('checked', '')} onclick="SetActive(${diagram.id},this.checked);" />${"$"}{lblActiv}</label>
</td>
</tr>
<tr>
<td class="CLASS04903">
<label class="CLASS04904"><input type="checkbox" ${diagram.operable?string('checked', '')} onclick="SetOperable(${diagram.id},this.checked);" />${"$"}{lblUsable}</label>
</td>
</tr>
<tr>
<td class="CLASS04903">
<label class="CLASS04904"><input type="checkbox" ${diagram.visible?string('checked', '')} onclick="SetVisible(${diagram.id},this.checked);" />${"$"}{lblVisible}</label>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
<!-- End Action Column -->        
        
    </tr>
    </#list>  
  

  </tbody>
</table>

<script type="text/javascript">
	SetActive = function(id, active)
	{
		var url = '/pages/jpages/diagram/settings/active?sid='+SessionId;
        var pb = "{";
        pb += '"id" : "' + id +'",';
        pb += '"value" :  "' + active +'"}';
        var opt = {
	        postBody: pb, 
	        onComplete: function(t){
				var response = JSON.parse(t.responseText);
                if(!response.isSuccessful)
                {
					if(response.errorCode == "42")
					{
						jQuery("#content").html(response.content);
					} else {
						alert(translateKey('diagramErrorCouldNotSave'));
					}
	        	}
	        }
        }
    	new Ajax.Request(url,opt);
	};
	
	SetOperable = function(id, operable)
	{
		var url = '/pages/jpages/diagram/settings/operable?sid='+SessionId;
        var pb = "{";
        pb += '"id" : "' + id +'",';
        pb += '"value" : "' + operable +'"}';
        var opt = {
	        postBody: pb, 
	        onComplete: function(t){
		        var response = JSON.parse(t.responseText);
                if(!response.isSuccessful)
                {
					if(response.errorCode == "42")
					{
						jQuery("#content").html(response.content);
					} else {
						alert(translateKey('diagramErrorCouldNotSave'));
					}
	        	}
	        }
        }
    	new Ajax.Request(url,opt);
	};
	
	SetVisible = function(id, visible)
	{
		var url = '/pages/jpages/diagram/settings/visible?sid='+SessionId;
        var pb = "{";
        pb += '"id" : "' + id +'",';
        pb += '"value" : "' + visible +'"}';
        var opt = {
	        postBody: pb, 
	        onComplete: function(t){
		        var response = JSON.parse(t.responseText);
                if(!response.isSuccessful)
                {
					if(response.errorCode == "42")
					{
						jQuery("#content").html(response.content);
					} else {
						alert(translateKey('diagramErrorCouldNotSave'));
					}
	        	}
	        }
        }
    	new Ajax.Request(url,opt);
	};
	
  DeleteDiagram = function(id)
  {
    var _id_ = id;
      new YesNoDialog(translateKey('dialogSafetyCheck'), translateKey('dialogQuestionRemoveDiagram'), function(result) {
      if (result == YesNoDialog.RESULT_YES)
      {
	        var url = '/pages/jpages/diagram/settings/delete?sid='+SessionId;
	        var pb = "{";
	        pb += '"id" : "' + _id_ +'"}';
	        var opt = {
		        postBody: pb, 
		        onComplete: function(t){
		        	var response = JSON.parse(t.responseText);
					if(!response.isSuccessful)
					{
						if(response.errorCode == "42")
						{
							jQuery("#content").html(response.content);
						} else {
							alert(translateKey('diagramErrorCouldNotDelete'));
						}
					} else {					
						reloadPage();
					}
		        }
	        }
        	new Ajax.Request(url,opt);
      }
    });
  };
  
	EditDiagram = function(id)
	{
		var url = '/pages/jpages/diagram/settings/showEdit?sid='+SessionId;
		var pb = "{";
		pb += '"id" : "' + id +'"}';
		var opt =
		{
			postBody: pb,
			onComplete: function(t)
			{
				var response = JSON.parse(t.responseText);
				if(!response.isSuccessful)
				{
					if(response.errorCode == "42")
					{
						jQuery("#content").html(response.content);
					} else {
						alert(translateKey(response.content));
					}
				} else {			
					jQuery("#content").html(response.content);
				}
			}
		}
		new Ajax.Request(url,opt);
	};
  
	NewDiagram = function()
	{  
		var url = '/pages/jpages/diagram/settings/showDiagramType?sid='+SessionId;
		var opt =
		{
			onComplete: function(t)
			{
				var response = JSON.parse(t.responseText);
				
				if(!response.isSuccessful)
				{
					if(response.errorCode == "42")
					{
						jQuery("#content").html(response.content);
					} else {
						alert(translateKey(response.content));
					}
				} else {			
					CreateCPPopup ("/pages/jpages/diagram/NewDiagramDialog.htm");
				}
			}
		}
		new Ajax.Request(url,opt);
	};
</script>
</body>
</html>