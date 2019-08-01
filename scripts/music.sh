#!/usr/bin/env bash

DISPLAY_SIZE=30

case $BLOCK_BUTTON in
  1) playerctl play-pause;; # Toggle music
  3) playerctl next;;       # Play next music
esac

TITLE=$(playerctl metadata title 2>/dev/null)
ALBUM=$(playerctl metadata album 2>/dev/null)

TEXT=$(echo "$TITLE - $ALBUM")
TEXT_LENGTH=$(echo $TEXT | iconv -f utf-8 -t ascii//translit | wc --chars)

if [ $TEXT_LENGTH -gt $DISPLAY_SIZE ]; then
  SCROLL=$(( $(date +%s) % $(( $TEXT_LENGTH - $DISPLAY_SIZE + 1 )) ))
  TEXT=${TEXT:SCROLL:DISPLAY_SIZE}
fi

TEXT=$(printf "%-30s" "$TEXT")

case $(playerctl metadata 2>/dev/null | head -n 1 | cut -d' ' -f1) in
  chrome) PLAYER="";;
  spotify) PLAYER="";;
  *) PLAYER="";;
esac

case $(playerctl -p spotify status 2>/dev/null) in
  Playing) echo "$PLAYER[:$TEXT]" ;;
  Paused) echo "$PLAYER[:$TEXT]" ;;
  *) echo "" ;;
esac
