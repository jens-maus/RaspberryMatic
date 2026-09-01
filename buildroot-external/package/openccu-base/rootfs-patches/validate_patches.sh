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

"${script_dir}/create_patches.sh" --check

while IFS= read -r patch_name || [[ -n $patch_name ]]; do
  [[ -n $patch_name && $patch_name != \#* ]] || continue
  patch -s -t -d "$state" -p1 -F0 -N <"${script_dir}/${patch_name}" || \
    die "patch does not apply with zero fuzz: $patch_name"
done <"${script_dir}/series"

for marker in \
  www/webui/webui.js \
  www/webui/style.css \
  www/config/st_values.cgi \
  opt/HMServer/pages/AvailableFirmware.ftl \
  usr/lib/tcl8.2/homematic/homematic.tcl; do
  [[ -s ${state}/${marker} ]] || die "patched rootfs is missing: $marker"
done

printf 'Validated %s patches against %s\n' \
  "$(grep -Ec '^[^#[:space:]]' "${script_dir}/series")" "$pristine_rootfs"
