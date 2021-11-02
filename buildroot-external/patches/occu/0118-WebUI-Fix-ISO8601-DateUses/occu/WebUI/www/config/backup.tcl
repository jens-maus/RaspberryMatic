source once.tcl
sourceOnce common.tcl
sourceOnce session.tcl
sourceOnce file_io.tcl
load tclrpc.so
load tclrega.so

proc create_backup {} {
  set HOSTNAME [exec hostname]
  set system_version [read_version "/VERSION"]
  set iso8601_date [exec date -Iseconds]
  set tmpdir [exec mktemp -d -p /usr/local/tmp]
  regexp {^(\d+)-(\d+)-(\d+)T(\d+):(\d+):(\d+)([+-].+)$} $iso8601_date dummy year month day hour minute second zone
  set backupfile [set HOSTNAME]-$system_version-$year-$month-$day-$hour$minute.sbk
  #save DOM
  rega system.Save()
  cd /
  if {[getProduct] < 3 } {
    catch { exec tar czf /tmp/usr_local.tar.gz usr/local }
  } else {
    catch { exec tar --owner=root --group=root --exclude=usr/local/tmp --exclude=usr/local/lost+found --exclude=usr/local/eQ-3-Backup --exclude-tag=.nobackup --one-file-system --ignore-failed-read -czf $tmpdir/usr_local.tar.gz usr/local }
  }
  
  cd $tmpdir/
  #sign the configuration with the current key
  exec crypttool -s -t 1 <usr_local.tar.gz >signature
  #store the current key index
  exec crypttool -g -t 1 >key_index
  file copy -force /VERSION firmware_version
  catch { exec tar --owner=root --group=root -cf /usr/local/tmp/last_backup.sbk usr_local.tar.gz signature firmware_version key_index }
  cd /
  exec rm -rf $tmpdir
  puts "X-Sendfile: /usr/local/tmp/last_backup.sbk"
  puts "Content-Type: application/octet-stream"
  puts "Content-Disposition: attachment; filename=\"$backupfile\"\n"
}
