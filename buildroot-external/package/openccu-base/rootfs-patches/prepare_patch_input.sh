#!/usr/bin/env bash
set -Eeuo pipefail
export LC_ALL=C

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

[[ $# == 1 || $# == 2 ]] || die "usage: ${0##*/} ROOTFS [OPENCCU_BASE_SOURCE]"
rootfs=$(cd "$1" && pwd -P)
webui_js=${rootfs}/www/webui/webui.js
rega_tcl=${rootfs}/www/tcl/eq3/rega.tcl

if (($# == 2)); then
  openccu_base_source=$(cd "$2" && pwd -P)
  mkdir -p "${rootfs}/bin" "${rootfs}/firmware"
  for script_name in hm_autoconf hm_deldev hm_startup; do
    if [[ ! -e ${rootfs}/bin/${script_name} ]]; then
      install -m 0755 "${openccu_base_source}/bin/${script_name}" \
        "${rootfs}/bin/${script_name}"
    fi
  done

  while IFS= read -r -d '' source_directory; do
    relative_path=${source_directory#"${openccu_base_source}/firmware"}
    mkdir -p "${rootfs}/firmware${relative_path}"
  done < <(find "${openccu_base_source}/firmware" -type d -print0)

  while IFS= read -r -d '' source_file; do
    relative_path=${source_file#"${openccu_base_source}/firmware/"}
    destination_file=${rootfs}/firmware/${relative_path}
    if [[ ! -e $destination_file && ! -L $destination_file ]]; then
      mkdir -p "$(dirname "$destination_file")"
      cp -a "$source_file" "$destination_file"
    fi
  done < <(find "${openccu_base_source}/firmware" \
    \( -type f -o -type l \) -print0)
fi

[[ -s $webui_js ]] || die "missing generated WebUI file: $webui_js"
[[ -s ${rootfs}/www/webui/style.css ]] || die "missing generated WebUI stylesheet"
[[ -s ${rootfs}/www/config/st_values.cgi ]] || die "missing generated WebUI configuration"
[[ -s ${rootfs}/opt/HMServer/pages/AvailableFirmware.ftl ]] || \
  die "missing generated HMServer files"
[[ -s ${rootfs}/usr/lib/tcl8.2/homematic/homematic.tcl ]] || \
  die "missing staged homematic Tcl package"
[[ -s ${rootfs}/bin/hm_autoconf ]] || die "missing staged hm_autoconf"
[[ -s $rega_tcl ]] || die "missing staged ReGa Tcl helper: $rega_tcl"

# The upstream file may arrive as CRLF while patch workspaces produced from a
# Buildroot source tree are LF-normalized. Canonicalize the staged rootfs copy
# here so normal builds, refreshes, and validation all use the same input.
sed -i.bak 's/\r$//' "$rega_tcl"
rm -f -- "${rega_tcl}.bak"

# Legacy WebUI patches were authored against these generated template strings
# split over physical lines. This must be called exactly once on a freshly
# staged rootfs.
sed -i.bak '1,10s/\\n/\\n\
/g' "$webui_js"
rm -f -- "${webui_js}.bak"
