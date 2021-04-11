#!/usr/bin/env bash

export DISPLAY=:0.0
CURRENT=""
HDMICLASS=$(find /sys/class/drm -name \*HDMI\*)

while true; do
  DUAL=$(cat $HDMICLASS/status)

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
