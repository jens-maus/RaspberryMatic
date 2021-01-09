#!/bin/bash

# Stop on error
set -e

# Script to install the RaspberryMatic container and its dependencies
# https://github.com/jens-maus/RaspberryMatic/wiki/en.Docker

#############################################################
#                           Settings                        #
#############################################################

#Rega Port
: ${CCU_REGA_HTTPS_PORT:=8443}

#Rega Port
: ${CCU_REGA_HTTP_PORT:=8080}

#ssh Port
: ${CCU_SSH_PORT:=2222}

#Other ports to open
: ${CCU_PORTS_TO_OPEN:="2001 2010 8181 9292"}

#Name of the docker volume where CCU data will persist
#It can be a local location as well such as a mounted NAS folder, cluster fs (glusterfs), etc.
: ${CCU_DATA_VOLUMEN:="ccu_data"}

# Container repository to use
: ${CCU_OCI_REPO:="ghcr.io/jens-maus/raspberrymatic"}

#CCU version to use
: ${CCU_OCI_TAG:="latest"}

#Name of the container instance (by default use same as angelnu/ccu for easier migration)
: ${CCU_CONTAINER_NAME:="ccu"}

#Additional options for docker create service / docker run
: ${CCU_DOCKER_OPTIONS:=""}

#Time for a clean container stop before it gets killed
: ${CCU_DOCKER_STOP_TIMEOUT:="30"}


#############################################################
#                           SCRIPT                          #
#############################################################

CWD=$(pwd)

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "WARNING: This script should be run as root" 1>&2
fi


#This only works on Debian/Ubuntu based OSes such as Armbian and Raspbian
if which dpkg>/dev/null && ! modinfo eq3_char_loop >/dev/null 2>&1 ; then
  echo "Installing pivcpu kernel modules"

  #Add repository
  echo "Add repository"
  apt install -y wget
  wget -q -O - https://www.pivccu.de/piVCCU/public.key | apt-key add -
  bash -c 'echo "deb https://www.pivccu.de/piVCCU stable main" > /etc/apt/sources.list.d/pivccu.list'
  apt update

  #Install kernel headers
  if which armbian-config>/dev/null; then
    echo "Detected Armbian - install kernel sources and device tree"
    apt install -y `dpkg --get-selections | grep 'linux-image-' | grep '\sinstall' | sed -e 's/linux-image-\([a-z0-9-]\+\).*/linux-headers-\1/'`
    apt install -y pivccu-devicetree-armbian
  elif grep -q Raspbian /etc/os-release; then
    echo "Detected Raspbian - install kernel sources and raspberry modules"
    apt install -y pivccu-modules-raspberrypi
    echo
    echo "NOTE: please ensure that your GPIO UART is free if you plan to connect your CCU adapter to it"
    echo "See step 5 and 6 at https://github.com/alexreinert/piVCCU/blob/master/docs/setup/raspberrypi.md"
  else
    echo "Uknown platform - trying generic way to install kernel headers"
    apt install -y linux-headers-$(uname -r)
  fi

  #Install & Build kernel modules
  echo "Install & Build kernel modules"
  apt install -y pivccu-modules-dkms
  service pivccu-dkms start
fi

echo "Load eq3_char_loop module"
modprobe eq3_char_loop || true
echo eq3_char_loop>/etc/modules-load.d/eq3_char_loop.conf || true

echo "Add udev rules"
cat <<'EOF' > /etc/udev/rules.d/99-Homematic.rules
  ACTION=="add", ATTRS{idVendor}=="1b1f", ATTRS{idProduct}=="c020", RUN+="/sbin/modprobe cp210x" RUN+="/bin/sh -c 'echo 1b1f c020 > /sys/bus/usb-serial/drivers/cp210x/new_id'"
EOF
udevadm control --reload-rules
udevadm trigger --action=add

#echo "Enable realtime"
#echo 'kernel.sched_rt_runtime_us=-1' > /etc/sysctl.d/10-ccu.conf || true
#sysctl -w kernel.sched_rt_runtime_us=-1 > /dev/null || true

echo "Remove old container if it exists"
docker stop ${CCU_CONTAINER_NAME} || true
docker rm ${CCU_CONTAINER_NAME} || true

echo "Pull/Update OCI image"
DOCKER_IMAGE="${CCU_OCI_REPO}:${CCU_OCI_TAG}"
docker pull ${DOCKER_IMAGE}

echo "Start container"
DOCKER_COMMAND="docker run -d -ti --privileged --restart=always --stop-timeout=30 -v"
#Persistent volume
DOCKER_COMMAND="${DOCKER_COMMAND} ${CCU_DATA_VOLUMEN}:/usr/local"
#Container and host names
DOCKER_COMMAND="${DOCKER_COMMAND} --hostname ${CCU_CONTAINER_NAME} --name ${CCU_CONTAINER_NAME}"
#Add extra ports
DOCKER_COMMAND="${DOCKER_COMMAND} -p ${CCU_SSH_PORT}:22 -p ${CCU_REGA_HTTP_PORT}:80 -p ${CCU_REGA_HTTPS_PORT}:443"
for extra_port in ${CCU_PORTS_TO_OPEN}; do
  DOCKER_COMMAND="${DOCKER_COMMAND} -p ${extra_port}:${extra_port}"
done
#Add timeout
DOCKER_COMMAND="${DOCKER_COMMAND} --stop-timeout ${CCU_DOCKER_STOP_TIMEOUT}"
#Add extra user options
DOCKER_COMMAND="${DOCKER_COMMAND} ${CCU_DOCKER_OPTIONS}"
#Add container repo
DOCKER_COMMAND="${DOCKER_COMMAND} ${DOCKER_IMAGE}"
#Execute command
$DOCKER_COMMAND

echo
echo "Docker container started!"
echo "- See logs with \"docker logs ${CCU_CONTAINER_NAME}\""
echo "- Connect to http://<this server IP>:${CCU_REGA_HTTP_PORT}"
