#!/usr/bin/env bash

DATE=$(date '+%A, %d %B %H:%M')

echo "[$DATE]"

case $BLOCK_BUTTON in
  1)
    notify-send -t 0 -a "Calendar" "
$(/usr/bin/cal -s --iso --color=never)"
    ;;
  3)
    setxkbmap -model abnt2 -layout br -variant abnt2 &> /dev/null
    ;;
esac
