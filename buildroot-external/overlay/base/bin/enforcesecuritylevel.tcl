#!/bin/tclsh
##
# Enforces configured security level.
# Copyright (C) 2018 eQ-3 Entwicklung GmbH
# Author: Niclaus
##

source "/lib/libsecuritylevel.tcl"

set lvl [ SEC_getsecuritylevel ]

catch [ SEC_applysecuritylevel $lvl ] {
	SEC_log "Error while enforcing security level $lvl"
}
