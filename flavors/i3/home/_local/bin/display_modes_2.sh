#!/usr/bin/env bash

IFS="
"

DISPLAYS=( $(xrandr | grep connected | cut -d ' ' -f 1) )
MODES=${#DISPLAYS[@]}

if [ $MODES -gt 1 ]; then
  DISPLAYS+=("DUAL")
  MODES=${#DISPLAYS[@]}
fi

if [ -f /tmp/current_display_mode ]; then
  CURRENT=$(cat /tmp/current_display_mode)
else
  CURRENT=3
fi

function write_mode() {
  echo $CURRENT > /tmp/display_mode
}

function apply_mode() {
  case ${DISPLAYS[$CURRENT]} in
    DUAL )
      xrandr --output eDP-1 --auto
      xrandr --output HDMI-1 --auto
      _configure_display
      ;;
    eDP-1 )
      xrandr --output eDP-1 --auto
      xrandr --output HDMI-1 --off
      ;;
    HDMI-1 )
      xrandr --output eDP-1 --off
      xrandr --output HDMI-1 --auto
      ;;
  esac
}

function next_mode() {
  case $CURRENT in
    DUAL )
      CURRENT=HDMI-1
      ;;
    HDMI-1 )
      CURRENT=eDP-1
      ;;
    eDP-1 )
      CURRENT=DUAL
      ;;
  esac
}

function prev_mode() {
  case $CURRENT in
    DUAL )
      CURRENT=eDP-1
      ;;
    HDMI-1 )
      CURRENT=DUAL
      ;;
    eDP-1 )
      CURRENT=HDMI-1
      ;;
  esac
}



case $BLOCK_BUTTON in
   1)
     next_mode
     apply_mode
     write_mode
     ;;
   3)
     prev_mode
     apply_mode
     write_mode
     ;;
esac

case $CURRENT in
  DUAL )
    echo " "
    ;;
  HDMI-1 )
  echo ""
    ;;
  eDP-1 )
  echo ""
    ;;
esac
