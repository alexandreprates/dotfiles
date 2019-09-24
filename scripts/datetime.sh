#!/usr/bin/env bash

DATE=$(date '+%A, %d %B %H:%M')

echo "[$DATE]"

case $BLOCK_BUTTON in
  1) setxkbmap -model abnt2 -layout br -variant abnt2 &> /dev/null ;;
esac
