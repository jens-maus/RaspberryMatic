#!/bin/bash
#
# helper script to patch the docker environment of homeassistant so that
# the raspberrymatic will be additionally connected via a macvlan interface
# to be able to connect a HmIP-HAP/HmIPW-DRAP.
#

echo "RaspberryMatic HA-Addon macvlan patch script"
echo "Copyright (c) 2023 Jens Maus <mail@jens-maus.de>"
echo

CCU_NETWORK_INTERFACE=$(ip -o -f inet route |grep -e "^default" | awk '{print $5}')
read -r -e -p "HomeAssistant Main Ethernet Interface (e.g. eth0): " -i "${CCU_NETWORK_INTERFACE}" CCU_NETWORK_INTERFACE </dev/tty

CCU_NETWORK_SUBNET=$(ip -o -f inet addr show dev "${CCU_NETWORK_INTERFACE}" | awk '/scope global/ {print $4}')
read -r -e -p "HomeAssistant Main Subnet (e.g. 192.168.178.0/24): " -i "${CCU_NETWORK_SUBNET}" CCU_NETWORK_SUBNET </dev/tty

CCU_NETWORK_GATEWAY=$(ip route list dev "${CCU_NETWORK_INTERFACE}" | awk ' /^default/ {print $3}')
read -r -e -p 'HomeAssistant Main Gateway (e.g. 192.168.178.1): ' -i "${CCU_NETWORK_GATEWAY}"  CCU_NETWORK_GATEWAY </dev/tty

CCU_CONTAINER_NAME=
read -r -p 'RaspberryMatic Add-on Hostname (e.g. 5422eb72-raspberrymatic): ' CCU_CONTAINER_NAME </dev/tty
if [[ -z "${CCU_CONTAINER_NAME}" ]]; then
  echo "ERROR: Must specify the hostname of the running RaspberryMatic add-on"
  exit 1
fi
CCU_CONTAINER_NAME=$(echo "addon_${CCU_CONTAINER_NAME}" | sed 's/-rasp/_rasp/')

CCU_CONTAINER_IP=$(echo "${CCU_NETWORK_GATEWAY}" | cut -d"." -f1-3)
read -r -e -p 'RaspberryMatic Add-on IP (e.g. 192.168.178.4): ' -i "${CCU_CONTAINER_IP}." CCU_CONTAINER_IP </dev/tty
if [[ -z "${CCU_CONTAINER_IP}" ]]; then
  echo "ERROR: Must specify a free ip to assign to RaspberryMatic add-on"
  exit 1
fi

# remove old macvlan
if docker network inspect ccu >/dev/null 2>&1; then
  echo "Removing docker macvlan ccu network bridge"
  docker network rm ccu
fi

# re-create docker macvlan network
echo "Creating docker macvlan network"
docker network create -d macvlan \
                      --opt parent="${CCU_NETWORK_INTERFACE}" \
                      --subnet "${CCU_NETWORK_SUBNET}" \
                      --gateway "${CCU_NETWORK_GATEWAY}" \
                      ccu

# check if add-on is running
if ! docker inspect "${CCU_CONTAINER_NAME}" >/dev/null 2>&1; then
  echo "ERROR: RaspberryMatic isn't running or hostname incorrect."
  exit 1
fi

echo "Connecting add-on to macvlan network"
docker network connect --ip "${CCU_CONTAINER_IP}" ccu "${CCU_CONTAINER_NAME}"

sleep 2

echo "Stopping add-on (${CCU_CONTAINER_NAME})"
docker stop "${CCU_CONTAINER_NAME}"

sleep 2

echo "Starting add-on (${CCU_CONTAINER_NAME})"
docker start "${CCU_CONTAINER_NAME}"

exit 0
