#!/bin/bash

ln -sf $HOME/.dunstrc $HOME/.dotfiles/dunstrc
ln -sf $HOME/.i3 $HOME/.dotfiles/i3
ln -sf $HOME/.i3blocks.conf $HOME/.dotfiles/i3/taskbar.conf
ln -sf $HOME/.lockscreen $HOME/.dotfiles/scripts/lockscreen
ln -sf $HOME/.xinitrc $HOME/.dotfiles/xinitrc
ln -sf $HOME/.zshrc $HOME/.dotfiles/zshrc

for theme in `ls $HOME/.dotfiles/oh_my_zsh_theme`
do
  ln -sf $HOME/oh_my_zsh_theme/$theme $HOME/.oh_my_zsh/themes/$theme
done

echo Done!