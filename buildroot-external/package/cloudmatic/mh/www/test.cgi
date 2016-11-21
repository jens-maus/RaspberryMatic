#!/bin/tclsh

package require HomeMatic
package require http

load tclrega.so

puts "test!"

exec /bin/echo status=1 >/etc/config/addons/mh/register_pending
puts "test2"
