#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'
export LC_ALL=C

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

[[ $# == 1 || $# == 2 ]] || \
  die "usage: ${0##*/} PRISTINE_ROOTFS [OPENCCU_BASE_SOURCE]"
patch --version 2>/dev/null | grep -q '^GNU patch ' || \
  die "GNU patch is required"
pristine_rootfs=$(cd "$1" && pwd -P)
if (($# == 2)); then
  openccu_base_source=$(cd "$2" && pwd -P)
else
  openccu_base_source=$(cd "${pristine_rootfs}/../.." && pwd -P)
fi
temp_dir=$(mktemp -d "${TMPDIR:-/tmp}/openccu-validate-patches.XXXXXX")
trap 'rm -rf -- "$temp_dir"' EXIT
state=${temp_dir}/rootfs
mkdir -p "$state"
cp -a "${pristine_rootfs}/." "$state/"
"${script_dir}/prepare_patch_input.sh" "$state" "$openccu_base_source"

assert_symlink() {
  local relative_path=$1
  local expected_target=$2
  local actual_target

  [[ -L ${state}/${relative_path} ]] || \
    die "patched rootfs is missing symlink: $relative_path"
  actual_target=$(readlink "${state}/${relative_path}")
  [[ $actual_target == "$expected_target" ]] || \
    die "wrong symlink target for $relative_path: $actual_target"
}

"${script_dir}/create_patches.sh" --check

while IFS= read -r patch_name || [[ -n $patch_name ]]; do
  [[ -n $patch_name && $patch_name != \#* ]] || continue
  patch -s -t -d "$state" -p1 -F0 -N <"${script_dir}/${patch_name}" || \
    die "patch does not apply with zero fuzz: $patch_name"
done <"${script_dir}/series"

"${script_dir}/finalize_patch_input.sh" "$state"
chmod 0755 "${state}/www/config/fileupload.ccc"

for marker in \
  www/webui/webui.js \
  www/webui/style.css \
  www/config/st_values.cgi \
  opt/HMServer/pages/AvailableFirmware.ftl \
  usr/lib/tcl8.2/homematic/homematic.tcl; do
  [[ -s ${state}/${marker} ]] || die "patched rootfs is missing: $marker"
done

while IFS=' ' read -r relative_path expected_target; do
  assert_symlink "$relative_path" "$expected_target"
done <<'SYMLINKS'
www/rega/EULA.de /tmp/EULA.de
www/rega/EULA.en /tmp/EULA.en
www/addons /etc/config/addons/www
www/cgi.tcl tcl/extern/cgi.tcl
www/common.tcl tcl/eq3_old/common.tcl
www/once.tcl tcl/eq3_old/once.tcl
www/session.tcl tcl/eq3_old/session.tcl
www/user.tcl tcl/eq3_old/user.tcl
www/api/eq3/rega.tcl ../../tcl/eq3/rega.tcl
www/api/eq3/session.tcl ../../tcl/eq3/session.tcl
www/pda/eq3/rega.tcl ../../tcl/eq3/rega.tcl
www/pda/eq3/session.tcl ../../tcl/eq3/session.tcl
www/config/cgi.tcl ../tcl/extern/cgi.tcl
www/config/common.tcl ../tcl/eq3_old/common.tcl
www/config/once.tcl ../tcl/eq3_old/once.tcl
www/config/session.tcl ../tcl/eq3_old/session.tcl
www/config/user.tcl ../tcl/eq3_old/user.tcl
www/config/display/cgi.tcl ../../tcl/extern/cgi.tcl
www/config/display/common.tcl ../../tcl/eq3_old/common.tcl
www/config/display/once.tcl ../../tcl/eq3_old/once.tcl
www/tools/cgi.tcl ../tcl/extern/cgi.tcl
www/tools/common.tcl ../tcl/eq3_old/common.tcl
www/tools/once.tcl ../tcl/eq3_old/once.tcl
www/tools/session.tcl ../tcl/eq3_old/session.tcl
SYMLINKS

[[ -x ${state}/www/config/fileupload.ccc ]] || \
  die "file upload CGI is not executable"

if find "$state" -type f -name '*.rej' -print -quit | grep -q .; then
  die "patched rootfs contains rejected hunks"
fi

repo_root=$(cd "${script_dir}/../../../.." && pwd -P)
tclsh=${TCLSH:-}
if [[ -z $tclsh ]]; then
  tclsh=$(command -v tclsh || true)
fi
[[ -x $tclsh ]] || die "Tcl interpreter not found; set TCLSH=/absolute/path/to/tclsh"

for tcl_file in \
  www/api/eq3/hmscript.tcl \
  www/pda/fav.cgi \
  www/pda/favlist.cgi \
  www/tcl/eq3/rega.tcl; do
  "$tclsh" /dev/stdin "${state}/${tcl_file}" <<'TCL'
set file_name [lindex $argv 0]
set channel [open $file_name r]
set contents [read $channel]
close $channel
if {![info complete $contents]} {
    puts stderr "incomplete Tcl script: $file_name"
    exit 1
}
TCL
done

fav_list_pattern="regexp {^[0-9]+\$} \$favListId"
fav_pattern="regexp {^[0-9]+\$} \$favId"
for pda_file in www/pda/fav.cgi www/pda/favlist.cgi; do
  grep -Fq "$fav_list_pattern" "${state}/${pda_file}" || \
    die "PDA favourite-list ID validation is missing from $pda_file"
done
grep -Fq "$fav_pattern" "${state}/www/pda/fav.cgi" || \
  die "PDA favourite ID validation is missing"

"$tclsh" "${repo_root}/scripts/testcases/security/rega_script_injection_test.tcl" \
  "$state"

printf 'Validated %s patches against %s\n' \
  "$(grep -Ec '^[^#[:space:]]' "${script_dir}/series")" "$pristine_rootfs"
