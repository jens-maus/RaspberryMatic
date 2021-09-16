#!/bin/tclsh
source once.tcl
sourceOnce cgi.tcl
sourceOnce session.tcl
sourceOnce common.tcl

load tclrpc.so
load tclrega.so

set INETCHECKFILENAME "/etc/config/internetCheckDisabled"
set RPI4USB3CHECKFILENAME "/etc/config/rpi4usb3CheckDisabled"
#set MEDIOLAFILENAME "/usr/local/addons/mediola/Disabled"
set MEDIOLAFILENAME "/etc/config/neoDisabled"
set NOUPDATEDCVARSFILENAME "/etc/config/NoUpdateDCVars"
set NOBADBLOCKSCHECKFILENAME "/etc/config/NoBadBlocksCheck"
set NOFSTRIMFILENAME "/etc/config/NoFSTRIM"
set DISABLELEDSFILENAME "/etc/config/disableLED"
set CUSTOMSTORAGEPATHFILENAME "/etc/config/CustomStoragePath"

set NOCRONBACKUPFILENAME "/etc/config/NoCronBackup"
set CRONBACKUPMAXBACKUPSFILENAME "/etc/config/CronBackupMaxBackups"
set CRONBACKUPPATHFILENAME "/etc/config/CronBackupPath"

set TWEAKFILENAME "/etc/config/tweaks"


proc createfile { filename } {
 set result ""

 if {![file exists $filename]} {
   catch {exec touch $filename} e

   if {[string trim $e] != ""} {
    set result "error createfile $filename \n"
   }
 }
 return $result
}

proc deletefile { filename } {
 set result ""
 
 if {[file exists $filename]} {
   catch {exec rm -f $filename} e

   if {[string trim $e] != ""} {
     set result "error deletefile $filename \n"
   }
 } 
 return $result
}

proc read_var_from_file { filename varname } {
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

proc readfile { filename } {
  set content ""
  if { [file exists $filename] } {
    set fd [open $filename r]
    set content [read $fd]
  }
  return $content
}

proc writefile { filename content } { 
  set fd -1
  catch {set fd [open $filename w]}
  if { $fd <0 } {return "$filename write error\n" }
  
  puts $fd $content
  close $fd
  return ""
}

proc put_message {title msg args} {
  division {class="popupTitle"} {
    puts $title
  }
  division {class="CLASS20900"} {
    table {class="popupTable CLASS20916"} {border="1"} {
      table_row {class="CLASS20917"} {
        table_data {
          puts $msg
        }
      }
    }
  }
  division {class="popupControls"} {
    table {
      table_row {
        if { [llength $args] < 1 } { set args {{"Zur&uuml;ck" "PopupClose();"}}}
        if {"_empty_" == $args} { set args "" }
        foreach b $args {
          table_data {class="CLASS20907"} {
            division {class="CLASS20908"} "onClick=\"[lindex $b 1]\"" {
              puts [lindex $b 0]
            }
          }
        }
      }
    }
  }

  cgi_javascript {
    puts "translatePage('#messagebox');"
  }
}

proc action_reboot_confirm {} {
  global env
   
  http_head
  division {class="popupTitle"} {
    puts "\${dialogSafetyCheck}"
  }
  division {class="CLASS20900"} {
    table {class="popupTable CLASS20901"} {border="1"} {
      table_row {
        table_data {
          table {class="CLASS20909"} {width="100%"} {
            table_row {
              table_data {colspan="3"} {
                puts "\${dialogQuestionRestart}"
              }
            }            
            table_row {
              table_data {align="right"} {class="CLASS20911"} {colspan="3"} {
                division {class="popupControls CLASS20905"} {
                  division {class="CLASS20910"} {onClick="OnNextStep()"} {
                    puts "\${dialogBtnPerformRestart}"
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  division {class="popupControls"} {
    table {
      table_row {
        table_data {class="CLASS20907"} {
          division {class="CLASS20908"} {onClick="dlgPopup.hide();showRMFeaturesCP();"} {
            puts "\${btnCancel}"
          }
        }
      }
    }
  }
  puts ""
  cgi_javascript {
    puts "var url = \"$env(SCRIPT_NAME)?sid=\" + SessionId;"
    puts {
      OnNextStep = function() {
        if (typeof regaMonitor != "undefined") {
          regaMonitor.stop();
          InterfaceMonitor.stop();
        }
        dlgPopup.hide();
        dlgPopup.setWidth(400);
        dlgPopup.LoadFromFile(url, "action=reboot_go");
      }
    }
    puts "dlgPopup.readaptSize();"
    puts "translatePage('#messagebox')"
  }
# Speichern wird beim Neustart durchgef�hrt, siehe action_reboot  
#  rega system.Save()
}

proc action_reboot_go {} {
  global env
  cd /tmp/
  
  http_head

  put_message "\${dialogPerformRebootTitle}" {
    ${dialogPerformRebootContent}
  } {"\${btnNewLogin}" "window.location.href='/';"}

  puts ""
  cgi_javascript {
    puts "var url = \"$env(SCRIPT_NAME)?sid=\" + SessionId;"
    puts {
      var pb = "action=reboot";
      var opts = {
        postBody: pb,
        sendXML: false
      };
      new Ajax.Request(url, opts);
    }
  }
}

proc action_reboot {} {
  catch { exec killall hss_lcd }
  catch { exec lcdtool {Saving   Data...  } }
  rega system.Save()
  catch { exec lcdtool {Reboot...       } }
  exec sleep 5
  exec /sbin/reboot
}

proc action_put_page {} {
  global env sid INETCHECKFILENAME RPI4USB3CHECKFILENAME MEDIOLAFILENAME NOCRONBACKUPFILENAME NOUPDATEDCVARSFILENAME NOBADBLOCKSCHECKFILENAME NOFSTRIMFILENAME CRONBACKUPMAXBACKUPSFILENAME CRONBACKUPPATHFILENAME CUSTOMSTORAGEPATHFILENAME TWEAKFILENAME DISABLELEDSFILENAME
   
  set inetcheckDisabled [file exists $INETCHECKFILENAME]
  set rpi4usb3CheckDisabled [file exists $RPI4USB3CHECKFILENAME]
  set mediolaDisabled [file exists $MEDIOLAFILENAME]
  set noCronBackup [file exists $NOCRONBACKUPFILENAME]
  set noDCVars [file exists $NOUPDATEDCVARSFILENAME]
  set noBadBlocksCheck [file exists $NOBADBLOCKSCHECKFILENAME]
  set noFSTRIM [file exists $NOFSTRIMFILENAME]
  set disableLEDs [file exists $DISABLELEDSFILENAME]

  set cronBackupMaxBackups [readfile $CRONBACKUPMAXBACKUPSFILENAME]
  set cronBackupPath [readfile $CRONBACKUPPATHFILENAME]
  set customStoragePath [readfile $CUSTOMSTORAGEPATHFILENAME]

  set tweaks [read_var_from_file $TWEAKFILENAME CP_DEVCONFIG]
  
  http_head
  
  division {class="popupTitle"} {
    puts "\${dialogSettingsRaspberryMaticFeaturesTitle}"
  }
  division {class="CLASS21114 j_translate"} {
    division {style="height:75vh;width:100%;overflow:auto;"} {
    table {class="popupTable"} {border=1} {width="100%"} {height="100%"} {
      table_row {class="CLASS21115"} {
        table_data {class="CLASS21116"} {
          puts "\${dialogSettingsRaspberryMaticFeaturesWatchDog}"
        }
        table_data {align=left} {class="CLASS02533"} {
          table {
            table_row {
              set checked ""
              if {!$inetcheckDisabled} { set checked "checked=true" }
              table_data {class="CLASS21112"} {colspan="3"} {
			  cgi_checkbox mode=inetcheckDisabled {id="cb_inetcheckDisabled"} $checked
			                  puts "\${dialogSettingsRaspberryMaticFeaturesInternetCheck}"
              }
            }			
			table_row {
              set checked ""
              if {!$rpi4usb3CheckDisabled} { set checked "checked=true" }
              table_data {class="CLASS21112"} {colspan="3"} {
			  cgi_checkbox mode=rpi4usb3CheckDisabled {id="cb_rpi4usb3CheckDisabled"} $checked
			                  puts "\${dialogSettingsRaspberryMaticFeaturesRpi4usb3Check}"
              }
            }
          }
        }
        table_data {class="CLASS21113"} {align="left"} {
          p { ${dialogSettingsRaspberryMaticFeaturesHintWatchDogCheck1} }
          p { ${dialogSettingsRaspberryMaticFeaturesHintWatchDogCheck2} }
        }
      }
      table_row {class="CLASS21115"} {
        table_data {class="CLASS21116"} {
          puts "\${dialogSettingsRaspberryMaticFeaturesSystem}"
        }
        table_data {align=left} {class="CLASS02533"} {
          table {
            table_row {			  
              set checked ""
              if {!$mediolaDisabled} { set checked "checked=true" }
              table_data {class="CLASS21112"} {colspan="3"} {
			  cgi_checkbox mode=mediolaDisabled {id="cb_mediolaDisabled"} $checked
			                  puts "\${dialogSettingsRaspberryMaticFeaturesMediola}"
              }
            }
            table_row { table_data {class="CLASS21112"} {colspan="3"} { puts "\<hr>" } }
            table_row {			  
              set checked ""
              if {!$noCronBackup} { set checked "checked=true" }
              table_data {class="CLASS21112"} {colspan="3"} {
			  cgi_checkbox mode=noCronBackup {id="cb_noCronBackup"} $checked
			                  puts "\${dialogSettingsRaspberryMaticFeaturesCronBackup}"
              }
            }
            table_row {
              table_data {class="CLASS21112"} {
                puts "\${dialogSettingsRaspberryMaticFeaturesCronBackupPath}"
              }

              table_data  {
                cgi_text cronBackupPath=$cronBackupPath {id="text_cronBackupPath"} {size=30}
              }
            }
            table_row {
              table_data {class="CLASS21112"} {
                puts "\${dialogSettingsRaspberryMaticFeaturesCronBackupMaxBackups}"
              }

              table_data  {
                cgi_text cronBackupMaxBackups=$cronBackupMaxBackups {id="text_cronBackupMaxBackups"} {size=5} {onpaste="validateNumber(this.value, this.id);"} {onkeyup="validateNumber(this.value, this.id);"}
              }
            }
            table_row { table_data {class="CLASS21112"} {colspan="3"} { puts "\<hr>" } }
			table_row {
              set checked ""
              if {!$noDCVars} { set checked "checked=true" }
              table_data {class="CLASS21112"} {colspan="3"} {
			  cgi_checkbox mode=noDCVars {id="cb_noDCVars"} $checked
			                  puts "\${dialogSettingsRaspberryMaticFeaturesDCVars}"
              }
            }
            table_row { table_data {class="CLASS21112"} {colspan="3"} { puts "\<hr>" } }
			table_row {
              set checked ""
              if {$disableLEDs} { set checked "checked=true" }
              table_data {class="CLASS21112"} {colspan="3"} {
			  cgi_checkbox mode=disableLEDs {id="cb_disableLEDs"} $checked
			                  puts "\${dialogSettingsRaspberryMaticFeaturesDisableLEDs}"
              }
            }
			table_row {
              set checked ""
              if {!$noBadBlocksCheck} { set checked "checked=true" }
              table_data {class="CLASS21112"} {colspan="3"} {
			  cgi_checkbox mode=noBadBlocksCheck {id="cb_noBadBlocksCheck"} $checked
			                  puts "\${dialogSettingsRaspberryMaticFeaturesBadBlocksCheck}"
              }
            }
			table_row {
              set checked ""
              if {!$noFSTRIM} { set checked "checked=true" }
              table_data {class="CLASS21112"} {colspan="3"} {
			  cgi_checkbox mode=noFSTRIM {id="cb_noFSTRIM"} $checked
			                  puts "\${dialogSettingsRaspberryMaticFeaturesFSTRIM}"
              }
            }
            table_row {
              table_data {class="CLASS21112"} {
                puts "\${dialogSettingsRaspberryMaticFeaturesCustomStoragePath}"
              }

              table_data  {
                cgi_text customStoragePath=$customStoragePath {id="text_customStoragePath"} {size=30} 
              }
            }
          }
        }
        table_data {class="CLASS21113"} {align="left"} {
          p { ${dialogSettingsRaspberryMaticFeaturesHintSystem1} }
          p { ${dialogSettingsRaspberryMaticFeaturesHintSystem2} }
          p { ${dialogSettingsRaspberryMaticFeaturesHintSystem3} }
          p { ${dialogSettingsRaspberryMaticFeaturesHintSystem4} }
          p { ${dialogSettingsRaspberryMaticFeaturesHintSystem5} }
          p { ${dialogSettingsRaspberryMaticFeaturesHintSystem6} }
          p { ${dialogSettingsRaspberryMaticFeaturesHintSystem7} }
          p { ${dialogSettingsRaspberryMaticFeaturesHintSystem8} }
          p { ${dialogSettingsRaspberryMaticFeaturesHintSystem9} }
        }
      }
	  
      table_row {class="CLASS21115"} {
        table_data {class="CLASS21116"} {
          puts "\${dialogSettingsRaspberryMaticFeaturesExpert}"
        }
        table_data {align=left} {class="CLASS02533"} {
          table {
            table_row {			  
              set checked ""
              if {$tweaks != ""} { set checked "checked=true" }
              table_data {class="CLASS21112"} {colspan="3"} {
			  cgi_checkbox mode=devConfig {id="cb_devConfig"} $checked
			                  puts "\${dialogSettingsRaspberryMaticFeaturesDevConfig}"
              }
            }

          }
        }
        table_data {class="CLASS21113"} {align="left"} {
          p { ${dialogSettingsRaspberryMaticFeaturesHintExpert1} }
        }
      }


    }
    }
  }
  division {class="popupControls"} {
    table {
      table_row {
        table_data {class="CLASS21103"} {
          division {class="CLASS21108"} {onClick="PopupClose()"} {
            #puts "Abbrechen"
            puts "\${btnCancel}"
          }
        }
        table_data {class="CLASS21103"} {
          division {id="btnOK"} {class="CLASS21108"} {onClick="OnOK()"} {
            #puts "OK"
            puts "\${btnOk}"
          }
        }
        table_data {class="CLASS21109"} {}
      }
    }
  }

  cgi_javascript {
    puts "var url = \"$env(SCRIPT_NAME)?sid=\" + SessionId;"
    puts {
      dlgResult = 0;
      OnOK = function() {
        var pb = "action=save_settings";
        pb += "&inetcheckDisabled="+(document.getElementById("cb_inetcheckDisabled").checked?"0":"1");
        pb += "&rpi4usb3CheckDisabled="+(document.getElementById("cb_rpi4usb3CheckDisabled").checked?"0":"1");
        pb += "&mediolaDisabled="+(document.getElementById("cb_mediolaDisabled").checked?"0":"1");
        pb += "&noCronBackup="+(document.getElementById("cb_noCronBackup").checked?"0":"1");
        pb += "&noDCVars="+(document.getElementById("cb_noDCVars").checked?"0":"1");
        pb += "&noBadBlocksCheck="+(document.getElementById("cb_noBadBlocksCheck").checked?"0":"1");
        pb += "&disableLEDs="+(document.getElementById("cb_disableLEDs").checked?"1":"0");
        pb += "&noFSTRIM="+(document.getElementById("cb_noFSTRIM").checked?"0":"1");
        pb += "&devConfig="+(document.getElementById("cb_devConfig").checked?"1":"0");
        pb += "&cronBackupPath="+document.getElementById("text_cronBackupPath").value;
        pb += "&cronBackupMaxBackups="+document.getElementById("text_cronBackupMaxBackups").value;
        pb += "&customStoragePath="+document.getElementById("text_customStoragePath").value;

        var opts = {
          postBody: pb,
          sendXML: false,
          onSuccess: function(transport) {
            if (transport.responseText === "") {   
              var dlgYesNo = new YesNoDialog(translateKey("dialogPerformRebootTitle"), translateKey("dialogSettingsRaspberryMaticFeaturesRebootHint"), function(result) {
                if (result == YesNoDialog.RESULT_YES) {
                  dlgPopup.hide();
                  dlgPopup.setWidth(400);
                  dlgPopup.LoadFromFile(url, "action=reboot_confirm");
                } else {
                  PopupClose();
                }
              });
          dlgYesNo.btnTextYes(translateKey("dialogBtnPerformRestart"));
          dlgYesNo.btnTextNo(translateKey("dialogBtnPerformLaterRestart"));
        
              
            } else { 
              alert(translateKey("dialogSettingsRaspberryMaticFeaturesMessageAlertMessageError1") + "\n" +transport.responseText); 
            }
          }
        };
        new Ajax.Request(url, opts);
      }      
    }
    
    puts {
      translatePlaceholder = function() {
        document.getElementById("text_customStoragePath").placeholder=translateKey("dialogSettingsRaspberryMaticFeaturesCustomStoragePathPlaceholder");
        document.getElementById("text_cronBackupPath").placeholder=translateKey("dialogSettingsRaspberryMaticFeaturesCronBackupPathPlaceholder");
      };
    }
    
	puts {
      validateNumber = function(num, elmId) {
	    var validator = /^(\s*|\d+)$/;
        var isValid = num.match(validator);
        btnOKElm = jQuery("#btnOK"),
		
        inputElm = jQuery("#"+elmId);

        if (isValid != null) {
         inputElm.css('background-color', '');
         btnOKElm.show();
        } else {
         inputElm.css('background-color', 'red');
         btnOKElm.hide();
        }
      };
	}
	
	puts "dlgPopup.setWidth(1020);";
    puts "translatePlaceholder();"
    puts "translatePage('#messagebox');"
    puts "dlgPopup.readaptSize();"
  }
  
}

proc action_save_settings {} {
  global INETCHECKFILENAME RPI4USB3CHECKFILENAME MEDIOLAFILENAME NOCRONBACKUPFILENAME NOUPDATEDCVARSFILENAME NOBADBLOCKSCHECKFILENAME NOFSTRIMFILENAME CRONBACKUPMAXBACKUPSFILENAME CRONBACKUPPATHFILENAME CUSTOMSTORAGEPATHFILENAME TWEAKFILENAME DISABLELEDSFILENAME
  set errMsg ""

  import inetcheckDisabled
  import rpi4usb3CheckDisabled
  import mediolaDisabled
  import noCronBackup
  import noDCVars
  import disableLEDs
  import noBadBlocksCheck
  import noFSTRIM
  import devConfig
  import cronBackupPath
  import cronBackupMaxBackups
  import customStoragePath
  
  if {$inetcheckDisabled} {
    append errMsg [createfile $INETCHECKFILENAME]
  } else {
    append errMsg [deletefile $INETCHECKFILENAME]
  }
  
  if {$rpi4usb3CheckDisabled} {
    append errMsg [createfile $RPI4USB3CHECKFILENAME]
  } else {
    append errMsg [deletefile $RPI4USB3CHECKFILENAME]
  }

  if {$mediolaDisabled} {
    append errMsg [createfile $MEDIOLAFILENAME]
  } else {
    append errMsg [deletefile $MEDIOLAFILENAME]
  }
  
  if {$noCronBackup} {
    append errMsg [createfile $NOCRONBACKUPFILENAME]
  } else {
    append errMsg [deletefile $NOCRONBACKUPFILENAME]
  }
  
  if {$noDCVars} {
    append errMsg [createfile $NOUPDATEDCVARSFILENAME]
  } else {
    append errMsg [deletefile $NOUPDATEDCVARSFILENAME]
  }
  
  if {$disableLEDs} {
    append errMsg [createfile $DISABLELEDSFILENAME]
  } else {
    append errMsg [deletefile $DISABLELEDSFILENAME]
  }  
  
  if {$noBadBlocksCheck} {
    append errMsg [createfile $NOBADBLOCKSCHECKFILENAME]
  } else {
    append errMsg [deletefile $NOBADBLOCKSCHECKFILENAME]
  }
  
  if {$noFSTRIM} {
    append errMsg [createfile $NOFSTRIMFILENAME]
  } else {
    append errMsg [deletefile $NOFSTRIMFILENAME]
  }

  if {$devConfig} {
    append errMsg [writefile $TWEAKFILENAME "CP_DEVCONFIG=1"]
  } else {
    append errMsg [deletefile $TWEAKFILENAME]
  }
  
  if { $cronBackupMaxBackups == "" || $cronBackupMaxBackups == "0" } {
    append errMsg [deletefile $CRONBACKUPMAXBACKUPSFILENAME]
  } else {
    append errMsg [writefile $CRONBACKUPMAXBACKUPSFILENAME $cronBackupMaxBackups]
  }
  
  if { $cronBackupPath == "" } {
    append errMsg [deletefile $CRONBACKUPPATHFILENAME]
  } else {
    append errMsg [writefile $CRONBACKUPPATHFILENAME $cronBackupPath]
  }
  
  if { $customStoragePath == "" } {
    append errMsg [deletefile $CUSTOMSTORAGEPATHFILENAME]
  } else {
    append errMsg [writefile $CUSTOMSTORAGEPATHFILENAME $customStoragePath]
  }
  
  puts "$errMsg"
}

cgi_eval {
  cgi_input
  set action "put_page"
  catch { import action }
  if {[session_requestisvalid 8] > 0} then action_$action
}
