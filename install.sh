#!/bin/bash

# Base devel
sudo pacman -S --needed base-devel

# Slim
sudo pacman -S slim archlinux-themes-slim

# xinitrc
sudo pacman -S xorg-xrand xorg-setxkbmap

# i3-wm
sudo pacman -S i3-wm dmenu

# i3
sudo pacman -S xautolock dunst feh terminology

# lockscreen
sudo pacman -S scrot imagemagick i3lock

# Others
sudo pacman -S thunar gitg

# R7 deps
sudo pacman -S redis

# Install aurget
curl https://gist.githubusercontent.com/alexandreprates/b47c6267194465fd888b/raw/572fc53953b8db0eb848712bf61829173643bf63/gistfile1.sh | bash

aurget -S i3blocks  --noedit --deps
aurget -S imagemagick-no-hdri  --noedit --deps
aurget -S sublime-text-nightly  --noedit --deps
aurget -S google-chrome --noedit --deps

aurget -S rabbitmq rabbitmqadmin