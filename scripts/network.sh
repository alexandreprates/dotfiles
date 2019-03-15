#!/usr/bin/env bash

ADAPTER=$(ip route | head -n 1 | cut -d ' ' -f 5)
IP=$(ip addr | grep inet | grep $ADAPTER | cut -d ' ' -f 6 | cut -d '/' -f 1)

case ${ADAPTER:0:1} in
  # e ) ICON="" ;;
  e ) ICON="" ;;
  # e ) ICON="" ;;
  w ) ICON="" ;;
esac

case $BLOCK_BUTTON in
  3) nm-connection-editor > /dev/null 2>&1 &;;
esac

echo "$ICON [$IP]"
