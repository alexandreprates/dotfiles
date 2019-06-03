#!/usr/bin/env bash

function toggleBluetooth() {
  if [ $STATUS eq "Off" ]; then
    pkexec service start bluetooth.service
  else
    pkexec service stop bluetooth.service
  fi
}

if hciconfig | grep DOWN > /dev/null ; then
  STATUS="Off"
else
  STATUS="On"
fi

# case $BLOCK_BUTTON in
#   1) toggleBluetooth ;;
# esac

echo " [$STATUS]"
