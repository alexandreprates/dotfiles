#!/bin/sh

playerctl pause
notify-send 'Pomodoro' 'Break time!'
convert -size 1440x900 xc:White -gravity Center -font "Font-Awesome-5-Free-Solid" -weight 700 -pointsize 600 -fill "graya(50%, 0.5)" -annotate +300+0 "  " -fill black -font "DejaVu-Sans-Book" -weight 700 -pointsize 200  -annotate 0 "Break\nTime!" png:- | feh -FZYx - &
