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
    eDP1 )
      xrandr --output eDP1 --auto
      xrandr --output HDMI1 --off
      ;;
    HDMI1 )
      xrandr --output eDP1 --off
      xrandr --output HDMI1 --auto
      ;;
    * )
      xrandr --output eDP1 --auto
      xrandr --output HDMI1 --auto
      _configure_display
      ;;
  esac
}

function next_mode() {
  case $CURRENT in
    HDMI1 )
      CURRENT=eDP1
      ;;
    eDP1 )
      CURRENT=DUAL
      ;;
    * )
      CURRENT=HDMI1
      ;;
  esac
}

function prev_mode() {
  case $CURRENT in
    HDMI1 )
      CURRENT=DUAL
      ;;
    eDP1 )
      CURRENT=HDMI1
      ;;
    * )
      CURRENT=eDP1
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
  HDMI1 )
  echo ""
    ;;
  eDP1 )
  echo ""
    ;;
esac
