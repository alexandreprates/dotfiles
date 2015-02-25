#!/bin/bash

# Base devel
pacman -S --needed base-devel

# xinitrc
pacman -S xorg-xrand xorg-setxkbmap

# i3-wm
pacman -S i3-wm dmenu 

# i3
pacman -S xautolock dunst feh terminology

# lockscreen
pacman -S scrot imagemagick i3lock
