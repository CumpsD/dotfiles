#!/bin/sh

STATUS=$(pgrep -a 'openvpn$' | head -n 1 | sed -r 's/.*nm-openvpn\/(.*)-ca.pem.*/\1/')

whitespace=$(printf '\n\t ')
case "$STATUS" in
  *[!$whitespace]*) echo "$STATUS";;
  *) echo "%{F#787e68}Disconnected%{F-}";;
esac
