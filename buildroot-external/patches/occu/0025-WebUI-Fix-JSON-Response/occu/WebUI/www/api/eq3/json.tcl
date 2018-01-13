##
# json.tcl
# JSON-Parser.
##

##
# Liest das erste Zeichen aus einem Text
##
proc json_getc { p_text {mode 0} } {
  upvar $p_text text
  
  if { "-nospace" == $mode } then { set text [string trimleft $text] }
  if { ""         == $text } then { return -code error "unexpected end of text" }
  
  set c    [string index $text 0]
  set text [string range $text 1 end]

  return $c
}

##
# Liefert das erste Zeichen aus einem Text, entfernt es jedoch nicht
##
proc json_preview { p_text {mode 0} } {
  upvar $p_text text
  
  if { "-nospace" == $mode } then { set text [string trimleft $text] }
  if { ""         == $text } then { return -code error "unexpected end of text" }
  
  return [string index $text 0]
}

##
# Parst ein JSON-Object in ein assoziatives Array
##
proc json_parse { text } {
  return [json_parseObject text]
}

##
# Parst ein JSON-Object in ein assoziatives Array
##
proc json_parseObject { p_text } {
  upvar $p_text text
  set object ""
  set c      ","
  
  if { "\{" != [json_getc text -nospace] } then {
    return -code error "\"\{\" expected"
  }
  
  if { "\}" != [json_preview text -nospace] } then {
    while { "," == $c } {
      set name  [json_parseString text]
      set c     [json_getc text -nospace]
      set value ""    
    
      if { ":" == $c } then {
        set value [json_parseValue text]
        set c     [json_getc text -nospace]
      }
      lappend object $name $value
    }
  } else {
    set c [json_getc text -nospace]
  }
  
  if { "\}" != $c } then {
    return -code error "\"\}\" expected"
  }
  
  return $object
}

##
# Parst ein JSON-Array in eine Liste
##
proc json_parseArray { p_text } {
  upvar $p_text text
  set values ""
  set c      ","
  
  if { "\[" != [json_getc text -nospace] } then {
    return -code error "\"\[\" expected"
  }
    
  if { "\]" != [json_preview text -nospace] } then {
    while { "," == $c } {
      lappend values [json_parseValue text]
      set c [json_getc text -nospace]
    }
  } else {
    set c [json_getc text -nospace]
  }
  
  if { "\]" != $c } then {
    return -code error "\"\]\" expected, but \"$c\" found"
  }
  
  return $values  
}

##
# Parst einen JSON-Wert
# ACHTUNG: Rekursion
##
proc json_parseValue { p_text } {
  upvar $p_text text
  set value ""
  
  switch -exact -- [json_preview text -nospace] {
    "\""    { set value [json_parseString text] }
    "\{"    { set value [json_parseObject text] }
    "\["    { set value [json_parseArray  text] }
    "n"     { set value [json_parseConstant text null] }
    "t"     { set value [json_parseConstant text true] }
    "f"     { set value [json_parseConstant text false] }
    default { set value [json_parseNumber text] }
  }
  
  return $value
}

##
# Parst eine Zeichenkette
##
proc json_parseString { p_text } {
  upvar $p_text text
  set str ""
  
  if { "\"" != [json_getc text -nospace]} then {
    return -code error "\" expected"
  }
  
  while { "\"" != [set c [json_getc text]] } {
    if { "\\" == $c } then {
      switch -exact -- [json_getc text] {
        "\"" { set c "\"" }
        "\\" { set c "\\" }
        "/"  { set c "/"  }
        "b"  { set c "\b" }
        "f"  { set c "\f" }
        "n"  { set c "\n" }
        "r"  { set c "\r" }
        "t"  { set c "\t" }
        "u"  { set c "[json_parseUnicodeChar text]" }
        default { return -code error "invaild escape code (\"\\$c\")" }
      }
    }
    append str $c
  }
  
  return $str
}

##
# Parst einen JSON-Zahlenwert
##
proc json_parseNumber { p_text } {
  upvar $p_text text
  set template {^-?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-][0-9]+)?}
  
  if { ![regexp -- $template $text number] } then {
    return -code error "number expected"
  }

  set text [string range $text [string length $number] end]
  return $number  
}

##
# Parst eine Konstante
##
proc json_parseConstant { p_text const } {
  upvar $p_text text
  
  set text [string trimleft $text]
  if { 0 == [string first $const $text] } then {
    set text [string range $text [string length $const] end]
  } else {
    return -code error "\"$const\" expected"
  }
  return $const
}

##
# Parst ein Unicode-Zeichen, welches über \uXXXX angegeben wurde
##
proc json_parseUnicodeChar { p_text } {
  upvar $p_text text
  
  set    c [json_getc text]
  append c [json_getc text]
  append c [json_getc text]
  append c [json_getc text]
  
  return [subst "\\u$c"]
}

##
# Codiert eine JSON-Zeichenkette
##
proc json_toString { str } {
  set map {
    "\"" "\\\""
    "\\" "\\\\"
    "/"  "\\/" 
    "\b"  "\\b" 
    "\f"  "\\f" 
    "\n"  "\\n" 
    "\r"  "\\r" 
    "\t"  "\\t" 
  }
  return "\"[string map $map $str]\""
}
