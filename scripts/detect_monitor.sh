#!/usr/bin/env bash

CURRENT=""

while true; do
  DUAL=$(cat /sys/class/drm/card0/card0-HDMI-A-1/status)

  if [ "$DUAL" == "connected" ] && [ "$CURRENT" != "dual" ]; then
    CURRENT="dual"
    xrandr --output HDMI-1 --auto --primary --left-of eDP-1
    sleep 2
    XCREEN=1
    while [ $XCREEN -le 5 ]
    do
      i3-msg "workspace $XCREEN"
      i3-msg "move workspace to primary"
      XCREEN=$(( $XCREEN + 1 ))
    done
    i3-msg "workspace 1"
  elif [ "$DUAL" == "disconnected" ] && [ "$CURRENT" != "single" ]; then
    CURRENT="single"
    xrandr --auto
    xrandr --output eDP-1 --primary
    sleep 1
    i3-msg "workspace 1"
  fi
  sleep 1
done
