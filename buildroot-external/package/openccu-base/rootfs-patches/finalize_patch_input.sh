#!/usr/bin/env bash
set -Eeuo pipefail
export LC_ALL=C

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

[[ $# == 1 ]] || die "usage: ${0##*/} ROOTFS"
rootfs=$(cd "$1" && pwd -P)
webui_js=${rootfs}/www/webui/webui.js

[[ -s $webui_js ]] || die "missing generated WebUI file: $webui_js"

# Undo prepare_patch_input.sh after the legacy patch series has been applied.
# Its inserted physical newlines occur directly after a literal "\n". Joining
# exactly that sequence preserves all other line endings in the generated file.
temp_file=${webui_js}.finalize.$$
trap 'rm -f -- "$temp_file"' EXIT
cp -p "$webui_js" "$temp_file"
awk '
  substr($0, length($0) - 1) == "\\n" { printf "%s", $0; next }
  { print }
' "$webui_js" >"$temp_file"
mv "$temp_file" "$webui_js"

# A remaining line ending in a literal "\n" means the generated JavaScript is
# still split inside a string literal and would be invalid in the browser.
if awk 'substr($0, length($0) - 1) == "\\n" { found=1 } END { exit !found }' \
  "$webui_js"; then
  die "failed to restore generated template strings in $webui_js"
fi
