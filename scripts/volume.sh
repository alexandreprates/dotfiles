#!/usr/bin/env bash

if pacmd stat | grep "sink" | grep "alsa_output.usb" > /dev/null; then
  OUTPUT=""
else
  OUTPUT=""
fi

VOLUME=$(amixer -D pulse sget Master | tail -n1 | cut -d ' ' -f 7)
if [ $(amixer -D pulse sget Master | tail -n1 | cut -d ' ' -f 8) == "[off]" ]; then
  VOLUME="[MUTE]"
fi

case $BLOCK_BUTTON in
  1) playerctl play-pause > /dev/null 2>&1;; # Toggle music
  2) amixer -D pulse sset Master toggle > /dev/null 2>&1;;  # right click, mute/unmute
  4) amixer -D pulse sset Master 5%- > /dev/null 2>&1;; # scroll up, increase
  5) amixer -D pulse sset Master 5%+ > /dev/null 2>&1;; # scroll down, decrease
esac

echo "$OUTPUT $VOLUME"
