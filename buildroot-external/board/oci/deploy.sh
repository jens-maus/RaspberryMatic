#!/bin/bash
#
# Script to install the RaspberryMatic container and its dependencies
# https://github.com/jens-maus/RaspberryMatic/wiki/en.Installation-Docker-OCI
#

# Stop on error
set -e

#############################################################
#                           Settings                        #
#############################################################

# Rega Port
: "${CCU_REGA_HTTPS_PORT:=8443}"

# Rega Port
: "${CCU_REGA_HTTP_PORT:=8080}"

# SSH Port
: "${CCU_SSH_PORT:=2222}"

# Other ports to open
: "${CCU_PORTS_TO_OPEN:="2001 2010 8181 9292"}"

# Name of the docker volume where CCU data will persist
# It can be a local location as well such as a mounted NAS folder, cluster fs (glusterfs), etc.
: "${CCU_DATA_VOLUME:="ccu_data"}"

# Container repository to use
: "${CCU_OCI_REPO:="ghcr.io/jens-maus/raspberrymatic"}"

# CCU version to use
: "${CCU_OCI_TAG:="latest"}"

# Name of the container instance (by default use same as angelnu/ccu for easier migration)
: "${CCU_CONTAINER_NAME:="ccu"}"

# Additional options for docker run
: "${CCU_DOCKER_RUN_OPTIONS:=""}"

# Additional options for docker pull
: "${CCU_DOCKER_PULL_OPTIONS:=""}"

# Do a docker pull to refresh image
: "${CCU_DOCKER_PULL_REFRESH:="true"}"

# Time for a clean container stop before it gets killed
: "${CCU_DOCKER_STOP_TIMEOUT:="30"}"

#############################################################
#                 DEPENDENCY INSTALLATION                   #
#############################################################

FORCE=
if [[ "${1}" == "-f" ]]; then
  FORCE="--assume-yes"
fi

check_sudo() {
  # Make sure only root can run our script
  if [[ $EUID -ne 0 ]]; then
    echo "ERROR: This script must be run as root/sudo"
    exit 1
  fi
}

pkg_installed() {
  PKG=${1}
  if dpkg -s "${PKG}" 2>/dev/null | grep -Eq "^Status:.*installed.*"; then
    return 0
  else
    return 1
  fi
}

# This only works on Debian/Ubuntu based OSes including Armbian and Raspberry Pi OS
if command -v dpkg >/dev/null; then

  # Add repository
  if [[ ! -e /etc/apt/sources.list.d/pivccu.list ]]; then
    echo "Adding piVCCU apt repository"
    check_sudo
    if ! pkg_installed wget; then
      apt install "${FORCE}" wget
    fi
    if ! pkg_installed ca-certificates; then
      apt install "${FORCE}" ca-certificates
    fi
    if ! pkg_installed build-essential; then
      apt install "${FORCE}" build-essential
    fi
    if ! pkg_installed flex; then
      apt install "${FORCE}" flex
    fi
    if ! pkg_installed libssl-dev; then
      apt install "${FORCE}" libssl-dev
    fi
    if ! pkg_installed gpg; then
      apt install "${FORCE}" gpg
    fi

    # use gpg to dearmor the pivccu public key
    wget -qO - https://www.pivccu.de/piVCCU/public.key | gpg --dearmor | tee /usr/share/keyrings/pivccu-archive-keyring.gpg >/dev/null
    sh -c 'echo "deb [signed-by=/usr/share/keyrings/pivccu-archive-keyring.gpg] https://www.pivccu.de/piVCCU stable main" >/etc/apt/sources.list.d/pivccu.list'
    apt update
  fi

  # Install kernel headers
  if command -v armbian-config >/dev/null; then
    echo "Detected Armbian - install kernel sources and device tree"
    check_sudo
    apt install "${FORCE}" "$(dpkg --get-selections | grep 'linux-image-' | grep '\sinstall' | sed -e 's/linux-image-\([a-z0-9-]\+\).*/linux-headers-\1/')"
    if ! pkg_installed pivccu-devicetree-armbian; then
      check_sudo
      apt install "${FORCE}" pivccu-devicetree-armbian
    fi
  elif grep -q Raspberry /proc/cpuinfo; then
    if ! pkg_installed pivccu-modules-raspberrypi; then
      echo "Detected RaspberryPi - install kernel sources and raspberry modules"
      check_sudo
      apt install "${FORCE}" pivccu-modules-raspberrypi
      echo
      echo "NOTE: please ensure that your GPIO UART is free if you plan to connect your CCU adapter to it"
      echo "See step 5 and 6 at https://github.com/alexreinert/piVCCU/blob/master/docs/setup/raspberrypi.md"
    fi
  elif ! pkg_installed "linux-headers-$(uname -r)"; then
    echo "Generic Debian/Ubuntu platform - trying generic way to install kernel headers"
    check_sudo
    apt install "${FORCE}" "linux-headers-$(uname -r)"
  fi

  # Install & Build kernel modules
  if ! pkg_installed pivccu-modules-dkms; then
    echo "Installing and building kernel modules..."
    check_sudo
    apt install "${FORCE}" pivccu-modules-dkms
    service pivccu-dkms start
  fi
fi

# setup /dev/eq3loop
if [[ ! -c /dev/eq3loop ]]; then
  echo "Loading eq3_char_loop module"
  check_sudo
  modprobe eq3_char_loop
fi
if [[ ! -e /etc/modules-load.d/eq3_char_loop.conf ]]; then
  echo "Installing eq3_char_loop to /etc/modules-load.d"
  check_sudo
  echo eq3_char_loop >/etc/modules-load.d/eq3_char_loop.conf
fi

if [[ ! -e /etc/udev/rules.d/99-Homematic.rules ]]; then
  echo "Adding/Updating udev rule"
  check_sudo
  cat <<'EOF' >/etc/udev/rules.d/99-Homematic.rules
ATTRS{idVendor}=="1b1f" ATTRS{idProduct}=="c020", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="1b1f" ATTRS{idProduct}=="c00f", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="0403" ATTRS{idProduct}=="6f70", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="10c4" ATTRS{idProduct}=="8c07", ENV{ID_MM_DEVICE_IGNORE}="1"
EOF
  udevadm control --reload-rules
  udevadm trigger --action=add
fi

#############################################################
#                      CONTAINER UPDATE                     #
#############################################################

if docker container inspect "${CCU_CONTAINER_NAME}" >/dev/null 2>&1; then
  echo "Stopping+Removing old container"
  docker stop "${CCU_CONTAINER_NAME}" >/dev/null || true
  docker rm "${CCU_CONTAINER_NAME}" >/dev/null || true
fi

DOCKER_IMAGE="${CCU_OCI_REPO}:${CCU_OCI_TAG}"
if [[ "${CCU_DOCKER_PULL_REFRESH}" == "true" ]]; then
  echo "Pull/Update OCI image ${DOCKER_IMAGE}"
  docker pull ${CCU_DOCKER_PULL_OPTIONS} ${DOCKER_IMAGE}
fi

#############################################################
#                      DOCKER STARTUP                       #
#############################################################

echo "Starting container:"
DOCKER_COMMAND="docker run -d -ti"

# system capabilities additions
#DOCKER_COMMAND="${DOCKER_COMMAND} --cap-add SYS_ADMIN --cap-add SYS_MODULE --cap-add SYS_NICE --cap-add SYS_RAWIO --security-opt seccomp=unconfined --security-opt apparmor:unconfined"
DOCKER_COMMAND="${DOCKER_COMMAND} --privileged"

# check for CONFIG_RT_GROUP_SCHED in kernel and if so
# add options to provide enough cpu shares to the ccu container
if [[ -e /sys/fs/cgroup/cpu/cpu.rt_runtime_us ]]; then
  DOCKER_COMMAND="${DOCKER_COMMAND} --cpu-rt-runtime 950000 --ulimit rtprio=99"
fi

# Persistent volume
DOCKER_COMMAND="${DOCKER_COMMAND} --volume ${CCU_DATA_VOLUME}:/usr/local:rw --volume /lib/modules:/lib/modules:ro"

# Container and host names
DOCKER_COMMAND="${DOCKER_COMMAND} --hostname ${CCU_CONTAINER_NAME} --name ${CCU_CONTAINER_NAME}"

# Add extra ports
DOCKER_COMMAND="${DOCKER_COMMAND} -p ${CCU_SSH_PORT}:22 -p ${CCU_REGA_HTTP_PORT}:80 -p ${CCU_REGA_HTTPS_PORT}:443"
for extra_port in ${CCU_PORTS_TO_OPEN}; do
  DOCKER_COMMAND="${DOCKER_COMMAND} -p ${extra_port}:${extra_port}"
done

# Add timeout
DOCKER_COMMAND="${DOCKER_COMMAND} --stop-timeout ${CCU_DOCKER_STOP_TIMEOUT} --restart always"

# Add extra user options
DOCKER_COMMAND="${DOCKER_COMMAND} ${CCU_DOCKER_RUN_OPTIONS}"

# Add container repo
DOCKER_COMMAND="${DOCKER_COMMAND} ${DOCKER_IMAGE}"

# Execute command
echo "${DOCKER_COMMAND}"
if ${DOCKER_COMMAND} >/dev/null; then
  echo
  echo "Docker container started!"
  echo "- See logs with \"docker logs ${CCU_CONTAINER_NAME}\""
  echo "- Connect to http://<this server IP>:${CCU_REGA_HTTP_PORT}"
  exit 0
else
  echo
  echo "ERROR: Failed to start docker container '${CCU_CONTAINER_NAME}'"
  exit 1
fi
