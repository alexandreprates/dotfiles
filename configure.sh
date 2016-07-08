#!/bin/bash

ln -sf $HOME/.dotfiles/dunstrc $HOME/.dunstrc 
ln -sf $HOME/.dotfiles/i3 $HOME/.i3
ln -sf $HOME/.dotfiles/i3/taskbar.conf $HOME/.i3blocks.conf
ln -sf $HOME/.dotfiles/scripts/lockscreen $HOME/.lockscreen
ln -sf $HOME/.dotfiles/xinitrc $HOME/.xinitrc
ln -sf $HOME/.dotfiles/zshrc $HOME/.zshrc

for theme in `ls $HOME/.dotfiles/oh_my_zsh_theme`
do
  ln -sf $HOME/oh_my_zsh_theme/$theme $HOME/.oh_my_zsh/themes/$theme
done

echo Config done!
