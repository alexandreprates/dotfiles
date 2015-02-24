#!/bin/sh

xrandr --output DVI-I-1 --auto --primary &
xrandr --output DP-1 --auto --right-of DVI-I-1 &

setxkbmap -model abnt2 -layout br -variant abnt2 &

exec i3
