#!/usr/bin/env bash
# shellcheck disable=SC2086
#
# Script to install a RaspberryMatic LXC container programatically.
# https://raw.githubusercontent.com/jens-maus/RaspberryMatic/master/scripts/install-lxc.sh
#
# Copyright (c) 2024 Jens Maus <mail@jens-maus.de>
# Apache 2.0 License applies
#
# Usage:
# wget -qO - https://raspberrymatic.de/install-lxc.sh | sudo bash -
#

# Setup script environment
set -o errexit  #Exit immediately if a pipeline returns a non-zero status
set -o errtrace #Trap ERR from shell functions, command substitutions, and commands from subshell
set -o nounset  #Treat unset variables as an error
set -o pipefail #Pipe will exit with last non-zero status if applicable
shopt -s expand_aliases
alias die='EXIT=$? LINE=${LINENO} error_exit'
trap die ERR
trap cleanup EXIT

# Set default variables
VERSION="1.0"
LOGFILE="/tmp/install-lxc.log"
LINE=

error_exit() {
  trap - ERR
  local DEFAULT='Unknown failure occured.'
  local REASON="\e[97m${1:-$DEFAULT}\e[39m"
  local FLAG="\e[91m[ERROR] \e[93m${EXIT}@${LINE}:"
  msg "${FLAG} ${REASON}"
  msg "${FLAG} \e[39mSee ${LOGFILE} for error details"
  exit "${EXIT}"
}
warn() {
  local REASON="\e[97m$1\e[39m"
  local FLAG="\e[93m[WARNING]\e[39m"
  msg "${FLAG} ${REASON}"
}
info() {
  local REASON="$1"
  local FLAG="\e[36m[INFO]\e[39m"
  msg "${FLAG} ${REASON}"
}
msg() {
  local TEXT="$1"
  echo -e "${TEXT}"
}

check_sudo() {
  # Make sure only root can run our script
  if [[ $EUID -ne 0 ]]; then
    die "This script must be run as root/sudo to modify host settings"
    exit 1
  fi
}

cleanup() {
  popd >/dev/null
  rm -rf "${TEMP_DIR}"
}

pkg_installed() {
  PKG=${1}
  if dpkg -s "${PKG}" 2>/dev/null | grep -Eq "^Status:.*installed.*"; then
    return 0
  else
    return 1
  fi
}

uninstall() {
  info "Purging/Uninstalling LXC container dependencies..."

  if [[ -e /etc/unrestricted.seccomp ]]; then
    info "Removing /etc/unrestricted.seccomp"
    rm -f /etc/unrestricted.seccomp
  fi

  if pkg_installed pivccu-modules-dkms; then
    info "Purging pivccu-modules-dkms"
    apt purge pivccu-modules-dkms
  fi

  HEADER_PKGS=
  if [[ "${PLATFORM}" == "aarch64" ]] &&
     command -v armbian-install >/dev/null; then
    # arm based Armbian system
    info "Identified arm64-based Armbian host system..."
    HEADER_PKGS="$(dpkg --get-selections | grep 'linux-image-' | grep -m1 '\sinstall' | sed -e 's/linux-image-\([a-z0-9-]\+\).*/linux-headers-\1/')"
  elif [[ "${PLATFORM}" == "aarch64" ]] &&
       grep -q Raspberry /proc/cpuinfo; then
    # arm based RaspberryPiOS system
    info "Identified arm64-based RaspberryPiOS host system..."
    HEADER_PKGS="raspberrypi-kernel-headers"
  elif [[ "${PLATFORM}" == "x86_64" ]]; then
    # full amd64/x86 based host system
    info "Identified x86-based host system..."
    HEADER_PKGS="linux-headers-$(uname -r)"
  else
    warn "Could not identify host system for kernel header uninstall"
  fi
  if [[ -n "${HEADER_PKGS}" ]]; then
    for pkg in ${HEADER_PKGS}; do
      if pkg_installed "${pkg}"; then
        info "Purging ${pkg}"
        apt purge "${pkg}"
      fi
    done
  fi

  # remove OS specific device tree stuff
  if pkg_installed pivccu-devicetree-armbian; then
    info "Purging pivccu-devicetree-armbian"
    apt purge pivccu-devicetree-armbian
  fi

  if pkg_installed pivccu-modules-raspberrypi; then
    info "Purging pivccu-modules-raspberrypi"
    apt purge pivccu-modules-raspberrypi
  fi

  if command -v armbian-install >/dev/null &&
     grep -q Raspberry /proc/cpuinfo &&
     [[ -f /boot/firmware/overlays/pivccu-raspberrypi.dtbo ]]; then

    info "Purging pivccu-raspberrypi.dtbo"
    rm -f /boot/firmware/overlays/pivccu-raspberrypi.dtbo
    sed -i '/^dtoverlay=pivccu-raspberrypi/d' /boot/firmware/config.txt
  fi

  # remove pivccu public key and repo
  if [[ -f /etc/apt/sources.list.d/pivccu.list ]]; then
    info "Removing pivccu apt repository"
    rm -f /etc/apt/sources.list.d/pivccu.list
  fi
  if [[ -f /usr/share/keyrings/pivccu-archive-keyring.gpg ]]; then
    info "Removing pivccu apt repository key"
    rm -f /usr/share/keyrings/pivccu-archive-keyring.gpg
  fi

  if pkg_installed pivccu-modules-dkms; then
    info "Uninstall pivccu-modules-dkms"
    apt purge pivccu-modules-dkms
  fi

  msg "LXC container host dependencies successfully removed."
  msg "- Only dependencies (kernel modules, etc.) were removed."
  msg "- No LXC container or related disks were removed. Revisit with \"pct list\""
  msg "- Use 'sudo apt autoremove' to remove all unnecessary dependencies again"
  msg "- Reboot your host system to ensure clean operation without dependencies."
}

msg "RaspberryMatic LXC installation script v${VERSION}"
msg "Copyright (c) 2024 Jens Maus <mail@jens-maus.de>"
msg ""

# create temp dir
TEMP_DIR=$(mktemp -d)
pushd "${TEMP_DIR}" >/dev/null

# check that this script is run as root/sudo
check_sudo

# remove existing log
rm -f "${LOGFILE}"

# check if this is a Proxmox system and if so
# request to use install-proxmox.sh instead
if [[ -d /etc/pve ]]; then
  die "You are trying to use 'install-lxc.sh' on a Proxmox VE system. Please use 'install-proxmox.sh' instead."
fi

# make sure we have the bare minimal dependencies installed
if ! command -v whiptail >/dev/null; then
  apt install -y whiptail
fi

# PVE platform
PLATFORM=$(uname -m)

# when executing with "uninstall" remove/purge all config files
# and dependency packages
if [[ "${1-}" == "uninstall" ]]; then
  if ! whiptail --title "Host dependency uninstall" \
	        --yesno "You are about to uninstall all LXC related host packages dependencies. This might require to manually reboot your host system afterwards.\n\nDo you want to continue?" \
                10 78; then
    die "aborting"
  fi
  uninstall
  exit 0
fi

text=$(cat <<EOF
When running RaspberryMatic as a LXC container, the host system
requires certain dependencies (e.g. kernel modules) to be installed.
During the next steps, correct installation of these dependencies is
checked and packages might get installed which require a manual reboot
of your LXC host system afterwards. Please note, that if you want to
uninstall these dependencies later you can run the install script
with the 'uninstall' parameter appended.

Do you want to continue now?
EOF
)

if ! whiptail --title "Host dependency check+installation" \
              --yesno "${text}" \
              15 78; then
  die "aborting"
fi

info "Checking/Installing host package dependencies..."

# check that all necessary host packages are installed
if ! pkg_installed wget; then
  apt install -y wget
fi
if ! pkg_installed ca-certificates; then
  apt install -y ca-certificates
fi
if ! pkg_installed build-essential; then
  apt install -y build-essential
fi
if ! pkg_installed bison; then
  apt install -y bison
fi
if ! pkg_installed flex; then
  apt install -y flex
fi
if ! pkg_installed libssl-dev; then
  apt install -y libssl-dev
fi
if ! pkg_installed gpg; then
  apt install -y gpg
fi
if ! pkg_installed lxc; then
  apt install -y lxc
fi

# use gpg to dearmor the pivccu public key
wget -qO - https://apt.pivccu.de/piVCCU/public.key | gpg --batch --yes --dearmor -o /usr/share/keyrings/pivccu-archive-keyring.gpg
sh -c 'echo "deb [signed-by=/usr/share/keyrings/pivccu-archive-keyring.gpg] https://apt.pivccu.de/piVCCU stable main" >/etc/apt/sources.list.d/pivccu.list'
apt update

# install kernel headers
HEADER_PKGS=
if [[ "${PLATFORM}" == "aarch64" ]] &&
   command -v armbian-install >/dev/null; then
  # arm based Armbian system
  info "Identified arm64-based Armbian host system..."
  HEADER_PKGS="$(dpkg --get-selections | grep 'linux-image-' | grep -m1 '\sinstall' | sed -e 's/linux-image-\([a-z0-9-]\+\).*/linux-headers-\1/')"
elif [[ "${PLATFORM}" == "aarch64" ]] &&
     grep -q Raspberry /proc/cpuinfo; then
  # arm based RaspberryPiOS system
  info "Identified arm64-based RaspberryPiOS host system..."
  HEADER_PKGS="raspberrypi-kernel-headers"
elif [[ "${PLATFORM}" == "x86_64" ]]; then
  # full amd64/x86 based host system
  info "Identified x86-based host system..."
  HEADER_PKGS="linux-headers-$(uname -r)"
else
  warn "Could not identify host platform for kernel header install"
fi
if [[ -n "${HEADER_PKGS}" ]]; then
  for pkg in ${HEADER_PKGS}; do
    if ! pkg_installed "${pkg}"; then
      info "Installing ${pkg}"
      apt install -y "${pkg}"
    fi
  done
fi

# install OS specific device tree stuff if RPI-RF-MOD
# or HM-MOD-RPI-PCB will be connected to the GPIO
if [[ "${PLATFORM}" == "aarch64" ]] &&
   ! pkg_installed pivccu-devicetree-armbian &&
   ! pkg_installed pivccu-modules-raspberrypi &&
   [[ ! -f /boot/firmware/overlays/pivccu-raspberrypi.dtbo ]]; then

   text=$(cat <<EOF
If you want to use a RPI-RF-MOD or HM-MOD-RPI-PCB on the GPIO port
of the ARM-based host hardware of this system, dedicated device tree
overlay modules have to be installed. If you, however, don't plan to
put a HomeMatic RF module on the GPIO bus but want to use a USB
connected RF module only (e.g. HmIP-RFUSB) you can (and should) skip
this step.

Do you want to install the device tree overlays for GPIO use?
EOF
)

  if whiptail --title "GPIO module/overlay installation check" \
              --yesno "${text}" \
              15 78; then

    if command -v armbian-install >/dev/null; then
      if grep -q Raspberry /proc/cpuinfo; then
        if [[ ! -f /boot/firmware/overlays/pivccu-raspberrypi.dtbo ]]; then
          info "Downloading pivccu-modules-raspberrypi"
          (cd "${TEMP_DIR}" && apt download pivccu-modules-raspberrypi)
          info "Extracting pivccu-modules-raspberrypi"
          (cd "${TEMP_DIR}" && ar x pivccu-modules-raspberrypi_*_all.deb)
          info "Extracting pivccu-raspberry.dtbo"
          (cd "${TEMP_DIR}" && tar -C "${TEMP_DIR}" -xf data.tar.xz ./var/lib/piVCCU/dtb/overlays/pivccu-raspberrypi.dtbo)
          info "Installing dtbo to /boot/firmware/overlays/"
          cp "${TEMP_DIR}/var/lib/piVCCU/dtb/overlays/pivccu-raspberrypi.dtbo" /boot/firmware/overlays/
          echo "dtoverlay=pivccu-raspberrypi" >>/boot/firmware/config.txt
        fi
      else
        info "Installing pivccu-devicetree-armbian"
        apt install -y pivccu-devicetree-armbian
      fi
    elif grep -q Raspberry /proc/cpuinfo; then
      info "Installing pivccu-modules-raspberrypi"
      apt install -y pivccu-modules-raspberrypi
    fi
  else
    info "Skipped GPIO overlay module installation step"
  fi
fi

# Install & Build homematic kernel modules
if ! pkg_installed pivccu-modules-dkms; then
  info "Building and installing homematic kernel modules..."
  apt install -y pivccu-modules-dkms
  service pivccu-dkms start
fi

# create /etc/unrestricted.seccomp for CTs
# which should have full hardware/kernel access
if [[ ! -e /etc/unrestricted.seccomp ]]; then
  cat <<EOF >/etc/unrestricted.seccomp
2
blacklist
# v2 allows comments after the second line, with '#' in first column,
# blacklist will allow syscalls by default
EOF
fi

case "${PLATFORM}" in
  x86_64)
    ENDSWITH="lxc_amd64.tar.xz"
  ;;
  aarch64)
    ENDSWITH="lxc_arm64.tar.xz"
  ;;
  arm*)
    ENDSWITH="lxc_arm.tar.xz"
  ;;
esac


# Select RaspberryMatic ova version
info "Getting available RaspberryMatic versions..."
RELEASES=$(cat<<EOF | python3
import requests
import os
import re
url = "https://api.github.com/repos/jens-maus/RaspberryMatic/releases"
r = requests.get(url).json()
if "message" in r:
    print("ERROR")
    exit()
num = 0
for release in r:
    if release["prerelease"] or release["tag_name"] == "snapshots":
      continue
    for asset in release["assets"]:
        if asset["name"].endswith("${ENDSWITH}") == True:
            image_url = asset["browser_download_url"]
            name = asset["name"]
            version = re.findall('RaspberryMatic-(\d+\.\d+\.\d+\.\d+(?:-[0-9a-f]{6})?)-?.*\.', name)
            if len(version) > 0 and num < 5:
                print(version[0] + ' release ' + image_url)
                num = num + 1
            break
EOF
)
if [[ "${RELEASES}" == "ERROR" ]]; then
  die "GitHub has returned an error. A rate limit may have been applied to your connection. Try again later."
fi

SNAPSHOTS=$(cat<<EOF | python3
import requests
import os
import re
url = "https://api.github.com/repos/jens-maus/RaspberryMatic/releases/tags/snapshots"
r = requests.get(url).json()
if "message" in r:
    print("ERROR")
    exit()
for asset in r["assets"]:
    if asset["name"].endswith("${ENDSWITH}") == True:
        image_url = asset["browser_download_url"]
        name = asset["name"]
        version = re.findall('RaspberryMatic-(\d+\.\d+\.\d+\.\d+(?:-[0-9a-f]{6})?)-?.*\.', name)
        if len(version) > 0:
          print(version[0] + ' snapshot ' + image_url)
        break
EOF
)

if [[ "${SNAPSHOTS}" == "ERROR" ]]; then
  die "GitHub has returned an error. A rate limit may have been applied to your connection. Try again later."
fi

if [[ -z "${RELEASES}${SNAPSHOTS}" ]]; then
  die "No RaspberryMatic release or snapshot build for '${PLATFORM}' PVE version found."
fi

if [[ -n "${RELEASES}" ]] && [[ -n "${SNAPSHOTS}" ]]; then
  RELEASES+=$'\n'${SNAPSHOTS}
elif [[ -n "${SNAPSHOTS}" ]]; then
  RELEASES=${SNAPSHOTS}
fi
MSG_MAX_LENGTH=0
RELEASES_MENU=()
i=0
while read -r line; do
  VERSION=$(echo "${line}" | cut -d' ' -f1)
  ITEM=$(echo "${line}" | cut -d' ' -f2)
  OFFSET=20
  if [[ $((${#ITEM} + OFFSET)) -gt ${MSG_MAX_LENGTH:-} ]]; then
    MSG_MAX_LENGTH=$((${#ITEM} + OFFSET))
  fi
  RELEASES_MENU+=("${VERSION}" " ${ITEM}")
  ((i=i+1))
done < <(echo "${RELEASES}")

RELEASE=$(whiptail --title "Select RaspberryMatic Version" \
                   --menu \
                     "Select RaspberryMatic version to install:\n\n" \
                     16 $((MSG_MAX_LENGTH + 23)) 6 \
                     "${RELEASES_MENU[@]}" 3>&1 1>&2 2>&3) || exit

# extract URL from RELEASES
prefix=${RELEASES%%"$RELEASE"*}
URL=$(echo ${RELEASES:${#prefix}} | cut -d' ' -f3)
info "Using ${RELEASE} for LXC container installation"

# enter userfs storage location
info "Entering userfs storage location"
USERFS_PATH=$(whiptail --title "User storage location selection" \
                       --inputbox "Please enter the user storage location/path that should\nbe used for the RaspberryMatic container." \
		       10 75 \
		       "/var/lib/raspberrymatic/userfs" \
                       3>&1 1>&2 2>&3)

mkdir -p "${USERFS_PATH}"

info "Using '${USERFS_PATH}' as userfs storage location."

# Select storage location
info "Entering container name"
CONTAINER_NAME=$(whiptail --title "Container name" \
                          --inputbox "Please enter a unique container name." \
		       10 75 \
		       "raspberrymatic" \
                       3>&1 1>&2 2>&3)

info "Using '${CONTAINER_NAME}' as container name."

# Download RaspberryMatic ova archive
info "Downloading disk image..."
wget -q --show-progress "${URL}"
echo -en "\e[1A\e[0K" #Overwrite output from wget
FILE=$(basename "${URL}")

# main installation steps
info "Creating LXC container config..."
cat <<EOF >>"${TEMP_DIR}/config"
lxc.include = LXC_TEMPLATE_CONFIG/common.conf
lxc.apparmor.profile = unconfined
lxc.seccomp.profile = /etc/unrestricted.seccomp
lxc.cap.drop =
lxc.rootfs.options = ro
lxc.mount.auto = proc:rw sys:rw cgroup:rw
lxc.cgroup2.devices.allow = c *:* rw
lxc.mount.entry = /lib/modules lib/modules none ro,bind 0 0
lxc.mount.entry = ${USERFS_PATH} usr/local none defaults,bind,noatime 0 0
lxc.hook.pre-start = sh -c "sysctl -q -w kernel.sched_rt_runtime_us=-1"
lxc.start.auto = 1
EOF
tar -C "${TEMP_DIR}" -cJf meta.tar.xz config

# create lxc container
info "Creating LXC container..."
lxc-create -n "${CONTAINER_NAME}" \
           -t local -- \
           -m "${TEMP_DIR}/meta.tar.xz" \
           -f "${FILE}"

msg "Completed Successfully. New CT is: \e[1m(${CONTAINER_NAME})\e[0m."
msg "- Start container via \"sudo lxc-start -n ${CONTAINER_NAME}\""
msg "- Access console via \"sudo lxc-console -n ${CONTAINER_NAME}\""
msg "- Connect to CCU via http://.../"
msg "- Stop container via \"sudo lxc-stop -n ${CONTAINER_NAME}\""
msg "- Destroy container via \"sudo lxc-destroy -n ${CONTAINER_NAME}\""
msg "- Uninstall LXC host dependencies via \"sudo ${0} uninstall\""
exit 0
