#!/bin/tclsh
source ../cgi.tcl

set ST_FILENAME "$env(DOCUMENT_ROOT)/config/stringtable_de.txt"
set JS_FILENAME "$env(DOCUMENT_ROOT)/config/st_values.js"
	
proc put_js_functions {} {

	global JS_FILENAME
	
	if { ! [catch {open $JS_FILENAME "r"} jsfile] } then {

		while {! [eof $jsfile] } {
			gets $jsfile zeile

			#Weiche EOF-Marke:
			if {$zeile == "//<."} then { break }
			
			puts $zeile
		}

		catch {close $jsfile}
	}
}

proc parse_line {zeile p_context p_value} {

	upvar $p_context context
	upvar $p_value   value
	
	set tokenizer [split $zeile "\t"]
	
	set context [lindex $tokenizer 0]
	set value   [lindex $tokenizer 1]
}

proc parse_file {} {

	global ST_FILENAME
	
	if { ! [catch {open $ST_FILENAME "r"} stFile] } then {

		puts "elvST = new Array();"
		
		while {! [eof $stFile] } {
			gets $stFile zeile

			if {$zeile == ""} then {
				continue
			}

      		if { [regexp {^([^\t]*)\t+(.*)$} $zeile dummy key value] } then {
	      		if { [regexp {^<.*>$} $value] } then {
					#Dieser Parameter wurde noch nicht übersetzt. Nicht ins JavaScript-Array einfü!
					continue
				}
			}

			set context ""
			set value ""
			
			parse_line $zeile context value
			
			puts "elvST\['$context'\] = '$value';"
		}
		
    	catch {close $stfile}
	}
}

cgi_http_head {
  cgi_content_type "text/javascript; charset=iso-8859-1"
}
parse_file
put_js_functions
