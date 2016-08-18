export ZSH=/home/aprates/.oh-my-zsh

ZSH_THEME="lost"

plugins=(git archlinux docker docker-compose ruby rbenv)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin"

# User configuration
source $HOME/.dotfiles/scripts/toolbox.sh
source $ZSH/oh-my-zsh.sh

PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
