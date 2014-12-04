#!/bin/sh

xrandr --output DVI-I-1 --mode 1440x900 --right-of DP-1 & #--rotate right &
xrandr --output DP-1 --auto --primary &

setxkbmap -model abnt2 -layout br -variant abnt2 &

exec i3
