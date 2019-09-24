#!/usr/bin/env bash

if [ -f /tmp/display_mode ]; then
  CURRENT=$(cat /tmp/display_mode)
else
  CURRENT=DUAL
fi

function write_mode() {
  echo $CURRENT > /tmp/display_mode
}

function apply_mode() {
  case $CURRENT in
    eDP-1 )
      xrandr --output eDP-1 --auto
      xrandr --output HDMI-1 --off
      ;;
    HDMI-1 )
      xrandr --output eDP-1 --off
      xrandr --output HDMI-1 --auto
      ;;
    * )
      xrandr --output eDP-1 --auto
      xrandr --output HDMI-1 --auto
      _configure_display
      ;;
  esac
}

function next_mode() {
  case $CURRENT in
    HDMI-1 )
      CURRENT=eDP-1
      ;;
    eDP-1 )
      CURRENT=DUAL
      ;;
    * )
      CURRENT=HDMI-1
      ;;
  esac
}

function prev_mode() {
  case $CURRENT in
    HDMI-1 )
      CURRENT=DUAL
      ;;
    eDP-1 )
      CURRENT=HDMI-1
      ;;
    * )
      CURRENT=eDP-1
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
