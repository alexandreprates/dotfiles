#!/bin/bash

function dotfile_link() {
  FILENAME=$1

  if [ -n "$2" ]; then
    DOTFILE="$HOME/.$2"
  else
    DOTFILE="$HOME/.$(basename $FILENAME)"
  fi

  [[ -s $DOTFILE ]] && mv $DOTFILE $DOTFILE.backup
  ln -sf $FILENAME $DOTFILE
}

for filename in $(pwd)/configs_and_inits/*; do
  dotfile_link $filename
done

dotfile_link $HOME/.dotfiles/i3/config i3

echo Config done!
