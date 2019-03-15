#!/bin/sh

export TERMINAL=/usr/bin/terminology

setxkbmap -model abnt2 -layout br -variant abnt2
xbindkeys

_xautolock -time 5 -locker ~/.lockscreen &
dunst -config ~/.dunstrc &
feh --randomize --bg-fill ~/.wallpapers &

xrandr --output HDMI-1 --primary --left-of eDP-1

exec $1
