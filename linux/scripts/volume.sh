#!/usr/bin/env bash

if pacmd stat | grep "sink" | grep "alsa_output.usb" > /dev/null; then
 OUTPUT=""
else
 OUTPUT=""
fi

VOLUME=$(amixer get Master | tail -n1 | cut -d ' ' -f 7)
if [ $(amixer get Master | tail -n1 | cut -d ' ' -f 8) == "[off]" ]; then
 VOLUME="[MUTE]"
fi

case $BLOCK_BUTTON in
 1) pavucontrol &> /dev/null ;;
 # 1) amixer -D pulse sset Master 2%+ > /dev/null 2>&1 ;;
 # 2) amixer -D pulse sset Master toggle > /dev/null 2>&1 ;;
 # 3) amixer -D pulse sset Master 2%- > /dev/null 2>&1 ;;
esac

echo "$OUTPUT$VOLUME"
