#!/bin/sh

# Number array of en interfaces.
EN_NUM="0 1 2"

# AFTR name
AFTR_FQDN="gw.transix.jp"

usage() {
  echo "Usage: ${COM} [on|off]"
  exit 1
}

enable() {
  echo "Setting up DS-Lite Tunnel."
  echo "Ethernet Interface: ${IF}"
  echo "MY_GUA: ${MY_GUA}"
  echo "AFTR_GUA: ${AFTR_GUA}"
  sudo ifconfig gif0 inet6 tunnel ${MY_GUA} ${AFTR_GUA}
  sudo ifconfig gif0 mtu 1500
  sudo ifconfig gif0 inet 192.0.0.2/30 192.0.0.1
  sudo route delete -inet default
  sudo route add -inet default 192.0.0.1
  sudo sysctl net.inet.ip.forwarding=1
  sudo sysctl net.inet6.ip6.gifhlim=64
#  sudo sysctl net.inet6.ip6.forwarding=1
}

disable() {
  echo "Tearing down DS-Lite Tunnel."
  sudo sysctl net.inet.ip.forwarding=0
  sudo sysctl net.inet6.ip6.gifhlim=0
#  sudo sysctl net.inet6.ip6.forwarding=0
  sudo route delete -inet default -interface gif0
  sudo ifconfig gif0 delete
  sudo ifconfig gif0 -tunnel
  sudo ifconfig gif0 mtu 1280
  echo "Resetting ${IF} for DHCP refreshing."
  sudo ifconfig ${IF} down
  sleep 2
  sudo ifconfig ${IF} up
}

get_my_gua() {
  for i in ${EN_NUM}
  do
    MY_GUA=`ifconfig en${i} inet6| grep 'inet6 2409:[0-9a-f:]*ff:fe[0-9a-f:]*' | sed 's/\%.*//' | cut -d ' ' -f 2`
    if [ "${MY_GUA}" ]; then
      IF="en${i}"
      return
    fi
  done
}
COM=`basename $0`
AFTR_GUA=`host ${AFTR_FQDN} | grep '2404:8e0' | sed -e '1!d' -e 's/.* address //'`
get_my_gua
if [ ! "${MY_GUA}" -o ! "${AFTR_GUA}" ]; then
  echo "Error: My Global Unicast Address and/or AFTR IPv6 Address not found."
  echo "MY_GUA: ${MY_GUA}"
  echo "AFTR_GUA: ${AFTR_GUA}"
  exit 1
fi
shopt -s nocasematch
case $1 in
  on)
    enable
    exit 0
    ;;
  off)
    disable
    exit 0
    ;;
  *)
    usage
esac
