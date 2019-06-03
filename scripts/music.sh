#!/usr/bin/env bash

DISPLAY_SIZE=30

case $BLOCK_BUTTON in
  1) playerctl play-pause;; # Toggle music
  3) playerctl next;;       # Play next music
esac

TITLE=$(playerctl metadata | grep title | cut -d " " -f 17-)
ALBUM=$(playerctl metadata | grep album | cut -d " " -f 17-)

TEXT=$(echo "$TITLE - $ALBUM" | iconv -f utf-8 -t ascii//translit)
TEXT_LENGTH=$(expr length "$TEXT")

if [ $TEXT_LENGTH -gt $DISPLAY_SIZE ]; then
  SCROLL=$(( $(date +%s) % $(( $TEXT_LENGTH - $DISPLAY_SIZE + 1 )) ))
  TEXT=${TEXT:SCROLL:DISPLAY_SIZE}
else
  TEXT=$(printf "%-30s" "$TEXT")
fi

if playerctl metadata | grep "spotify" > /dev/null; then
  PLAYER=""
fi

case $(playerctl status) in
  Playing)
    echo "$PLAYER  [$TEXT]"
    ;;
  Paused)
    echo "$PLAYER  [$TEXT]"
    ;;
  *)
    echo ""
  ;;
esac
