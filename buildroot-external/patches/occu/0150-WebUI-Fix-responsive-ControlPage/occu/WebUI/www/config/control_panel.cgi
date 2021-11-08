#!/bin/tclsh

package require HomeMatic

source once.tcl
sourceOnce common.tcl
sourceOnce session.tcl

#**
#* @fn read_var
#* @brief Liest den Wert eines Parameters aus eine Konfigurationsdatei
#*
#* @param filename Dateiname der Konfigurationsdatei
#* @param varname  Bezeichnung des Parameters
#*
#* @returns Wert des ausgelesenen Parameters oder "",
#*          falls der Parameter nicht gelesen werden konnte
#**
proc read_var { filename varname} {
    set var ""

    set fd -1
    catch { set fd [open $filename r] }
    if { $fd >=0 } {
        while { [gets $fd buf] >=0 } {
          if [regexp "^ *$varname *= *(.*)$" $buf dummy var] break
        }
      close $fd
    }
  
    return $var
}

http_head

puts {
  <script type="text/javascript">
    function include_once(src)
    {
      var script_elements=document.getElementsByTagName('script');
      for(var i=0;i<script_elements.length;i++){
        if(script_elements.item(i).getAttribute('src')==src){
          return;
        }
      }
      var html_doc = document.getElementsByTagName('head').item(0);
      var js = document.createElement('script');
      js.setAttribute('language', 'javascript');
      js.setAttribute('type', 'text/javascript');
      js.setAttribute('src', src);
      html_doc.appendChild(js);
    }
    setPath("<span onclick='WebUI.enter(SystemConfigPage);'>"+ translateKey("menuSettingsPage") +"</span> &gt; " + translateKey("submenuSysControl"));
    setFooter("");
  </script>

  <div id="configMainTable" style="display:none">
    
    
    
    <!-- Zentralen-Wartung -->
    <div class="cpCell">
      <div class="cpButton">
        <div class="StdTableBtn CLASS21701" onclick="showMaintenanceCP()">${btnSysConfCentralMaintenace}</div>
        <div class="StdTableBtnHelp"><img id="showMaintenanceCPHelp" src="/ise/img/help.png"></div>
      </div>
    </div>

    <!-- Sicherheit -->
    <div class="cpCell">
      <div class="cpButton">
        <div class="StdTableBtn CLASS21701" onclick="showSecurityCP()">${btnSysConfSecurity}</div>
        <div class="StdTableBtnHelp"><img id="showSecurityCPHelp" src="/ise/img/help.png"></div>
      </div>
    </div>

    <!-- Zeit- und Positionseinstellung -->
    <div class="cpCell">
      <div class="cpButton">
        <div  class="StdTableBtn CLASS21701" onclick="showTimeCP()">${btnSysConfTimePosSettings}</div>
        <div class="StdTableBtnHelp"><img id="showTimeCPHelp" src="/ise/img/help.png"></div>
      </div>
    </div>
}
if {[isOldCCU]} {
  puts {
      <!-- Zenralen-Display-Einstellungen -->
      <div class="cpCell">
        <div  class="StdTableBtn CLASS21703" onclick="showDisplayCP()">${btnSysConfDisplayConfig}</div>
     </div>

     <div class="cpCell _CLASS21702"></div>

     

  }
}
    
puts { 
    <!-- Netzwerkeinstellungen -->
    <div class="cpCell">
      <div class="cpButton">
        <div class="StdTableBtn CLASS21701" onclick="showNetworkCP()">${btnSysConfNetworkConfig}</div>
        <div class="StdTableBtnHelp"><img id="showNetworkCPHelp" src="/ise/img/help.png"></div>
      </div>
    </div>
}


if {[getProduct] >= 3} {
  puts {
    <div class="cpCell">
      <div class="cpButton">
        <div class="StdTableBtn CLASS21701" onclick="new FirewallConfigDialog();">${btnSysConfFirewallConfig}</div>
        <div class="StdTableBtnHelp"><img id="newFirewallConfigDialogHelp" src="/ise/img/help.png"></div>
      </div>
    </div>
  }
} else {
  puts {
    <div class="cpCell">
      <div class="cpButton">
        <div class="StdTableBtn CLASS21701" onclick="new FirewallConfigDialog_CCU2();">${btnSysConfFirewallConfig}</div>
        <div class="StdTableBtnHelp"><img id="newFirewallConfigDialogHelp" src="/ise/img/help.png"></div>
      </div>
    </div>
  }
}

if {[isOldCCU]} {
  puts {
    <div class="cpCell">
	 <div class="cpButton">
      <div class="StdTableBtn CLASS21701" onclick="ConfigData.check(function() { WebUI.enter(BidcosRfPage); });">${btnSysConfBidCosConfig}</div>
      <ul>
        <li>${lblSysConfBidCosConfig1}</li> <!-- interne Antenne konfigurieren -->
        <li>${lblSysConfBidCosConfig2}</li> <!-- HomeMatic Funk-LAN-Gateways verwalten -->
      </ul>
  }
} else {
  puts {
    <div class="cpCell">
      <div class="cpButton">
        <div class="StdTableBtn CLASS21701" onclick="ConfigData.check(function() { WebUI.enter(BidcosRfPage); });">${btnSysConfLANGateway}</div>
  }
}

  puts {
        <div class="StdTableBtnHelp"><img id="showBidCosConfigHelp" src="/ise/img/help.png"></div>
      </div>
    </div>

    <!-- Zusatzsoftware -->
    <div class="cpCell">
      <div class="cpButton">
        <div  class="StdTableBtn CLASS21701" onclick="showSoftwareCP();">${btnSysConfAdditionalSoft}</div>
        <div class="StdTableBtnHelp"><img id="showSoftwareCPHelp" src="/ise/img/help.png"></div>
      </div>
    </div>

    <!-- Storage Settings -->
    <div class="cpCell">
      <div class="cpButton">
        <div class="StdTableBtn CLASS21701" onclick="showGeneralSettingsCP();">${btnSysConfGeneralSettings}</div>
        <div class="StdTableBtnHelp"><img id="showGeneralSettingsCPHelp" src="/ise/img/help.png"></div>
      </div>
    </div>

  
  }

    if {[getProduct] >= 3} {
    puts {
      <!-- Button Security Wizard - slimmed down InstallWizard without the admin password dialog -->

      <div class="cpCell">
        <div  class="StdTableBtn CLASS21701" onclick="new DialogChooseSecuritySettings();">${btnSecuritySettings}</div>
        <div class="StdTableBtnHelp"><img id="showSecuritySettingsCPHelp" src="/ise/img/help.png"></div>
      </div>
    }
  
  }

  puts {
    <!-- Kopplungen -->
    <div class="cpCell">
      <div class="cpButton">
        <div class="StdTableBtn CLASS21701" onclick="showCouplingCP();">${btnSysConfCoupling}</div>
        <div class="StdTableBtnHelp"><img id="showCouplingCPHelp" src="/ise/img/help.png"></div>
      </div>
    </div>
  }
  

  if { [getProduct] >= 3} {
    puts "<div class=\"cpCell\"><div class=\"cpButton\">"
    puts "<div class=\"StdTableBtn CLASS21701\" onclick=\"showAccessPoint();\">\${btnAccessPoints}</div>"
    puts "<div class=\"StdTableBtnHelp\"><img id=\"showAccessPointCPHelp\" src=\"/ise/img/help.png\"></div>"
	puts "</div></div>"
  
  }

  puts {
    <div class="cpCell">
      <div class="cpButton">
        <div class="StdTableBtn CLASS21701" onclick="showAdvancedSettingsCP()">${btnSysConfAdvancedSettings}</div>
        <div class="StdTableBtnHelp"><img id="showAdvancedSettingsCPHelp" src="/ise/img/help.png"></div>
      </div>
    </div>
   }
  

if { "[read_var /etc/config/tweaks CP_DEVCONFIG]" != "" } {
  puts "<div class=\"cpCell\"><div class=\"cpButton\">"
  puts "<div class=\"StdTableBtn CLASS21701\" onclick=\"window.open('/tools/devconfig.cgi?sid=$sid');\">DevConfig</div>"
  puts "<div class=\"StdTableBtnHelp\"></div></div></div>"
}


array set addons [::HomeMatic::Addon::GetAll]
foreach addonId [array names addons] {
  if {($addonId != "mediola") || ($addonId == "mediola") && ([file exists "/etc/config/neoDisabled"] != 1)} {
    array set addon $addons($addonId)

    array set arrDESCR $addon(CONFIG_DESCRIPTION)

    puts "<div class=\"cpCell\">"
      puts "<div class='cpButton'>"
        puts "<div class=\"StdTableBtn CLASS21701\" onclick=\"window.open('$addon(CONFIG_URL)?sid=$sid');\">$addon(CONFIG_NAME)</div>"
        puts "<div id=\"btnAddOn_$addonId\" class=\"StdTableBtnHelp j_addOn\"><img id=\"showAddonInfo_$addonId\" src=\"/ise/img/help.png\"></div>"

        #puts "<ul id=\"description_$addonId\" style=\"display:none\">$addon(CONFIG_DESCRIPTION)</ul>"
        puts "<ul id=\"description_$addonId\" style=\"display:none\"></ul>"
      puts "</div>"
    puts "</div>"

     puts "<script type=\"text/javascript\">"

       puts "var lang = getLang();"
       puts "var addOnDescr = \{\};"
       foreach key [array names arrDESCR] {
         puts "addOnDescr\['$key'\] = '$arrDESCR($key)';"
       }
       puts "var descr = addOnDescr\[lang\];"

       puts "if (descr == null || typeof descr == 'undefined'){"
        puts "descr = addOnDescr\[getDefaultLang()\];"
       puts "}"

       puts "if (descr != null && typeof descr != 'undefined') {"
        puts "jQuery('#description_$addonId').html(descr);"
       puts "} else { jQuery('#description_$addonId').html(''); }"

     puts "</script>"


    array_clear addon
  }
}


puts {
  </div>
}


puts {
  <script type="text/javascript">

    function createAddOnTooltips() {
       jQuery.each(jQuery(".j_addOn"), function(index, elem){
         var addonId = elem.id.split("_")[1],
         helpTxtId = "description_" + addonId,
         tooltipHTML = "<h1>"+ jQuery("#"+elem.id).prev().children(":first").text() +"</h1><ul>" + jQuery("#" + helpTxtId).html()+"</ul>",
         tooltipElem = jQuery("#showAddonInfo_" + addonId) ;

        if ((tooltipHTML != "") && (typeof tooltipHTML != "undefined") && (tooltipHTML != null)) {
          tooltipElem.data('powertip', tooltipHTML);
          tooltipElem.powerTip({placement: 'se', followMouse: true});
        } else {
          // If no html available hide the tooltip element (the questionmark)
          tooltipElem.hide();
        }
      });
    };

    function setLineHeight() {
      jQuery('.CLASS21701').each(function(index, elem) {
        var elem = jQuery(elem),
        br = elem.html().match(/\<br\/\>|\<br\>/gi);

        if (br != null) {
          // change line-height from default(40px) to 20px
          elem.css('line-height', '20px');
        }
      });
    };

    function setTooltips() {
      var helpContainer = ["#showMaintenanceCPHelp","#showSecurityCPHelp","#showTimeCPHelp","#showNetworkCPHelp","#newFirewallConfigDialogHelp","#showBidCosConfigHelp","#showSoftwareCPHelp", "#showCouplingCPHelp", "#showGeneralSettingsCPHelp", "#showAccessPointSettingsCPHelp", "#showSecuritySettingsCPHelp", "#showAccessPointCPHelp", "#showAdvancedSettingsCPHelp"];
      var help = [
        "<h1>"+translateKey("btnSysConfCentralMaintenace")+"</h1><ul><li>"+translateKey("lblSysConfCentralMaintenance1")+"</li><li>"+translateKey("lblSysConfCentralMaintenance2")+"</li><li>"+translateKey("lblSysConfCentralMaintenance3")+"</li></ul>",
        "<h1>"+translateKey("btnSysConfSecurity")+"</h1><ul><li>"+translateKey("lblSysConfSecurity1")+"</li><li>"+translateKey("lblSysConfSecurity2")+"</li><li>"+translateKey("lblSysConfSecurity3")+"</li><li>"+translateKey("lblSysConfSecurity4")+"</li><li>"+translateKey("lblSysConfSecurity5")+"</li><li>"+translateKey("lblSysConfSecurity6")+"</li><li>"+translateKey("lblSysConfSecurity7")+"</li><li>"+translateKey("lblSysConfSecurity8")+"</li></ul>",
        "<h1>"+translateKey("btnSysConfTimePosSettings")+"</h1><ul><li>"+translateKey("lblSysConfTimePosSettings1")+"</li><li>"+translateKey("lblSysConfTimePosSettings2")+"</li><li>"+translateKey("lblSysConfTimePosSettings3")+"</li><li>"+translateKey("lblSysConfTimePosSettings4")+"</li></ul>",
        "<h1>"+translateKey("btnSysConfNetworkConfig")+"</h1><ul><li>"+translateKey("lblSysConfNetworkConfig1")+"</li><li>"+translateKey("lblSysConfNetworkConfig2")+"</li></ul>",
        "<h1>"+translateKey("btnSysConfFirewallConfig")+"</h1><ul><li>"+translateKey("lblSysConfFirewallConfig1")+"</li><li>"+translateKey("lblSysConfFirewallConfig2")+"</li></li></ul>",
        "<h1>"+translateKey("btnSysConfLANGateway")+"</h1><ul><li>"+translateKey("lblSysConfBidCosConfig2")+"</li></ul>",
        "<h1>"+translateKey("btnSysConfAdditionalSoft")+"</h1><ul><li>"+translateKey("lblSysConfAdditionalSoft1")+"</li><li>"+translateKey("lblSysConfAdditionalSoft2")+"</li></ul>",
        "<h1>"+translateKey("btnSysConfCoupling")+"</h1><ul><li>OSRAM Lightify</li><li>Philips Hue</li></ul>",
        "<h1>"+translateKey("btnSysConfGeneralSettings")+"</h1><ul><li>"+translateKey("lblSysConfStorage")+"</li><li>"+translateKey("lblSysConfSetPowerCost")+"</li></ul>",
        "<h1>"+translateKey("btnAccessPointSettings")+"</h1><ul><li>"+translateKey("lblAccessPointSettings1")+"</li></ul>",
        "<h1>"+translateKey("btnSecuritySettings")+"</h1><ul><li>"+translateKey("lblSecuritySettings1")+"</li><li>"+translateKey("lblSecuritySettings2")+"</li></ul>",
        "<h1>"+translateKey("btnAccessPoints")+"</h1><ul><li>"+translateKey("lblShowAllAPs")+"</li></ul>",
        "<h1>"+translateKey("btnSysConfAdvancedSettings")+"</h1><ul><li>"+translateKey("lblSysConfAdvancedSettings1")+"</li></ul>"
        ];

       jQuery.each(helpContainer, function(index, container){
        var element = jQuery(container);
        var tooltip = help[index];
        element.data('powertip', tooltip);
        element.powerTip({placement: 'se', followMouse: true});
       });
    };

    translatePage("#content");
    setLineHeight();
    setTooltips();

    // Using a try block in case an addon has an incorrect tooltip description or so...
    try {
      createAddOnTooltips();
    } catch(e) {};

    jQuery("#configMainTable").show();
  </script>
}
