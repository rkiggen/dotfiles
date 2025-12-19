#!/bin/sh


function get_wlan_iface() {
  local _wlan_iface="$( printf '%s\n' /sys/class/net/*/wireless | cut -d/ -f5 )"
  echo "$_wlan_iface"
}

function get_ip_address() {
  local _iface=$1
  local _output="$( ip addr show "${_iface}" 2>/dev/null )"
  local _ip_address="$(     echo "${_output}" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1 )"
  echo "$_ip_address"
}

if [ -n "${BLOCK_INSTANCE:-}" ]; then
  iface="${BLOCK_INSTANCE}"
else
  iface=$(get_wlan_iface)
fi

# interface is down
if [[ "$iface" = "" ]] || [[ "$(cat /sys/class/net/$iface/operstate)" = 'down' ]]; then
  echo "${iface}:(down)" # full text
  echo "${iface}:(down)" # short text
  echo \#FF0000 # color (red)
  exit 33
fi


ip_address=$(get_ip_address "${iface}")
echo "${iface}:(${ip_address})"
exit 0






