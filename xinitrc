#!/bin/sh

export TERMINAL=/usr/bin/terminology

setxkbmap -model abnt2 -layout br -variant abnt2
xbindkeys

xautolock -time 5 -locker ~/.lockscreen &
dunst -config ~/.dunstrc &
feh --randomize --bg-fill ~/.wallpapers &
clipit &

exec $1
