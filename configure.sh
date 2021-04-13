#!/bin/bash

# Create link in $HOME/.$FILENAME
function placefile() {
  FILENAME=$1

  if [ -n "$2" ]; then
    DOTFILE="$HOME/.$2"
  else
    DOTFILE="$HOME/.$(basename $FILENAME)"
  fi

  [[ -s $DOTFILE ]] && mv $DOTFILE $DOTFILE.backup
  ln -sf $FILENAME $DOTFILE
}

function configureLinux() {
  for filename in $(pwd)/linux/configs_and_inits/*; do
  	echo $filename
  	placefile $filename
  done

  dotfile_link $HOME/.dotfiles/i3/config i3
}

function configureMac() {
  for filename in $(pwd)/linux/configs_and_inits/*; do
  	echo $filename
  	placefile $filename
  done

  # Installs
  # Brew https://brew.sh/index_pt-br
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  brew install zsh git gpg vim

  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # go2dir https://github.com/alexandreprates/go2dir
  curl https://raw.githubusercontent.com/alexandreprates/go2dir/master/install | bash
}


unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     configureLinux;;
    Darwin*)    configureMac;;
    *)          echo "Unsupported OS!"; exit 1;;
esac

echo Please insert your git email address && read MYEMAIL

git config --global commit.gpgsign true
git config --global user.email "$MYEMAIL"
git config --global user.name "Alexandre Prates"

echo Config done!
