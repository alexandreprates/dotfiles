#!/usr/bin/env bash

BRIGHT=$(brightnessctl -m | cut -d, -f4)

case $BLOCK_BUTTON in
  1) brightnessctl s 5%+ > /dev/null 2>&1;;
  3) brightnessctl s 5%-  > /dev/null 2>&1;;
esac

# echo " [$BRIGHT]"
echo " [$BRIGHT]"