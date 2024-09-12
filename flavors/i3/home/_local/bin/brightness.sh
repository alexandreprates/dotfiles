#!/usr/bin/env bash

BRIGHT=$(light -G | cut -d. -f1)

case $BLOCK_BUTTON in
  1) light -S $(expr $(light -G | cut -d. -f1) + 5) > /dev/null 2>&1;;
  3) light -S $(expr $(light -G | cut -d. -f1) - 5)  > /dev/null 2>&1;;
esac

# echo " [$BRIGHT]"
echo "[$BRIGHT%]"
