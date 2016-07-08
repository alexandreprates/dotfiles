#!/bin/sh

#xrandr --output DP1 --auto --primary --output DP2 --auto --rotate left --left-of DP1 --output VGA1 --auto --right-of DP1
setxkbmap -model abnt2 -layout br -variant abnt2
xbindkeys &

export TERMINAL=/usr/bin/terminology
exec $1
